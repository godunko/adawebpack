------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--                         S Y S T E M . M E M O R Y                        --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 2001-2020, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  TLSF based implementation for LLVM/WASM

pragma Restrictions (No_Elaboration_Code);
--  This unit may be linked without being with'ed, so we need to ensure
--  there is no elaboration code (since this code might not be executed).

with Interfaces;

with System.Address_To_Access_Conversions;
with System.Storage_Elements;
with System.Machine_Code;

package body System.Memory is
   use type Interfaces.Unsigned_32;
   use type Interfaces.Unsigned_64;

   --  There are a few configuration parameters to tune allocations:
   --  Threshold, Raw_Alloc_Limit and Split_Bits.

   Threshold   : constant := 64;
   --  Split a free block into two if extra size >= Threshold

   Raw_Alloc_Limit : constant := 64 * 1024;
   --  Minimum low level allocation size when heap is exhausted.

   Split_Bits  : constant := 4;
   --  Firstly, we round size to Standard'Maximum_Alignment to always have good
   --  allignment. This way we always have 4 low zero bits. We keep lists of
   --  free memory blocks in groups depending on block size.
   --  Each group has 2 ** Split_Bits lists.
   --  Group  | Size            | Comment
   --  Group 0: 0000xxxx 0....0 - exact block size group
   --  Group 1: 0000xxxx 10...0 - exact block size group too
   --  Group 2: 00000xxxx 10..0 - size/2 group
   --  Group 3: 000000xxxx 10.0 - size/4 group
   --  ..................................
   --  Group N: 000000000xxxx 1 - last group,
   --        LSB^             ^ MSB (most significant bit)
   --  where N is Addr'Size - Align_Bits - Split_Bits
   --  First_Level_Index corresponds to a group index, Second_Level_Index to
   --  the list index inside a group.

   Align_Bits : constant := 4;

   pragma Compile_Time_Error
     (2 ** Align_Bits /= Standard'Maximum_Alignment,
      "Wrong Align_Bits definition");

   Addr_Size   : constant := Standard'Address_Size;

   Last_Group : constant := Addr_Size - Align_Bits - Split_Bits;
   --  Number of the last free block list group.

   type First_Level_Index is range 0 .. Last_Group;
   type Second_Level_Index is mod 2 ** Split_Bits;

   type List_Index is record
      First_Level  : First_Level_Index;
      Second_Level : Second_Level_Index;
   end record;
   --  Index in 2-dimensial array of free block index.

   function Get_List_Index (Value : size_t) return List_Index;
   --  Get optimal list index for a block of given size.

   type Block;  --  Free or bust block of memory.
   type Block_Access is access all Block;

   Free_List : array (First_Level_Index, Second_Level_Index) of Block_Access :=
     (others => (others => null));
   --  Array of free block lists.

   Bit_Map_Last : constant :=
     (Free_List'Length (1) * Free_List'Length (2) + 63) / 64 - 1;

   type Free_List_Bit_Map is
     array (Interfaces.Unsigned_32 range 0 .. Bit_Map_Last) of
       Interfaces.Unsigned_64;

   Bit_Map : Free_List_Bit_Map := (others => 0);
   --  Service boolean array to speed up search for free blocks
   --  Contains 0 if corresponding list in Free_Lists is empty

   function Is_List_Present (Index : List_Index) return Boolean with Inline;
   procedure Set_List_Present (Index : List_Index) with Inline;
   procedure Cleat_List_Present (Index : List_Index) with Inline;

   function Get_Bit_Index (Index : List_Index) return Interfaces.Unsigned_32 is
     (Interfaces.Unsigned_32 (Index.First_Level) * Free_List'Length (2)
       + Interfaces.Unsigned_32 (Index.Second_Level));
   --  For given list index return bit index in the Bit_Map array.

   procedure Find_Next_List (Index : in out List_Index; Found : out Boolean);
   --  Search for a non-empty free block list starting from given Index.

   procedure Delete_From_List (Block : Block_Access; Index : List_Index);
   --  Delete theBlock from the free block list with given Index.

   procedure Append_To_List (Block : Block_Access);
   --  Append the Block to a corresponding free block list.

   Last_Block : Block_Access;
   --  Last accessible block in memory (block with highest address).

   type Block_Reference is new System.Address;
   --  Block_Reference is a block address and a boolean mark in the same word.

   function To_Reference
     (Value : not null Block_Access;
      Mark  : Boolean := False) return Block_Reference with Inline;
   --  Cast block access to a reference

   function To_Block (Value : Block_Reference) return Block_Access with Inline;
   --  Cast block reference to a block access

   function Is_Marked (Value : Block_Reference) return Boolean with Inline;
   --  Return boolean mark

   procedure Set_Mark
     (Value : in out Block_Reference;
      Mark  : Boolean := True) with Inline;
   --  Assign boolean mark

   type Neighbour_Blocks is record
      Prev : Block_Reference := 0;  --  Mark = Is_Free
      Next : Block_Reference := 0;  --  Mark = Is_Last_Block
   end record;
   --  Double linked list chain for connecting blocks ordered by their address.
   --  For the Last_Block, Next points to the first byte outside of available
   --  memory and its Mark is set.

   type Free_List_Chain is record
      Prev : Block_Access;
      Next : Block_Access;
   end record;
   --  Double linked list chain for connecting blocks of almost the same size.

   Header_Size : constant := 4 * Standard'Address_Size / Standard'Storage_Unit;

   type Block is record
      Near : Neighbour_Blocks;  --  Blocks located before/after in the memory
      Akin : Free_List_Chain;   --  Refs in a free list, when block is free
      Data : Character;
   end record;

   function Size (Value : not null Block_Access) return size_t with Inline;
   --  Return size of block excluding Header

   function Next (Value : not null Block_Access) return Block_Access is
     (if Is_Marked (Value.Near.Next)
       then null
       else To_Block (Value.Near.Next));
   --  Return next block if any

   function Prev (Value : not null Block_Access) return Block_Access is
      (To_Block (Value.Near.Prev));
   --  Return previous block

   function Is_Free (Value : not null Block_Access) return Boolean is
      (Is_Marked (Value.Near.Prev));
   --  Check if given block is free

   procedure Split_Block (Block : not null Block_Access; Size : size_t);
   --  Split a part of given Block into a separate block and append it to a
   --  corresponding free list. After this call the Block has given Size.

   package Cast is new System.Address_To_Access_Conversions (Block);

   function Count_Leading_Zeros (Value : size_t) return Natural
     with No_Inline;
   --  with Import, Convention => C, External_Name => "@llvm.ctlz.i32";
   --  Count leading 0 in the Value.

   function Count_Trailing_Zeros
     (Value : Interfaces.Unsigned_64) return Interfaces.Unsigned_64
       with No_Inline;
   --  Count trailing 0 in the Value.

   function Low_Level_Allocation (Size : size_t) return System.Address;
   --  Allocate additional memory when current heap is exhausted.
   --  Return zero if no allocation is possible. Return first byte in
   --  inaccessible memory otherwise.

   Heap_Base : aliased Block
     with Alignment  => Standard'Maximum_Alignment,
          Import     => True,
          Convention => C,
          Link_Name  => "__heap_base";
   --  The address of the variable is the start of the heap

   ----------------
   -- For C code --
   ----------------

   function C_Malloc (Size : size_t) return System.Address;
   pragma Export (C, C_Malloc, "malloc");

   function C_Calloc
    (N_Elem : size_t; Elem_Size : size_t) return System.Address;
   pragma Export (C, C_Calloc, "calloc");

   procedure C_Free (Ptr : System.Address);
   pragma Export (C, C_Free, "free");

   -----------
   -- Alloc --
   -----------

   function Alloc (Size : size_t) return System.Address is
      Max_Align : constant := Standard'Maximum_Alignment;
      Max_Size  : constant size_t :=
        ((Size + Max_Align - 1) / Max_Align) * Max_Align;
      --  Compute aligned size

      Index     : List_Index := Get_List_Index (Max_Size);
      Found     : Boolean := True;
      Block     : Block_Access;

   begin
      --  Detect overflow in the addition below. Note that we know that
      --  upper bound of size_t is bigger than the upper bound of
      --  Storage_Count.

      if Size > size_t (Storage_Elements.Storage_Count'Last) - Max_Align then
         raise Storage_Error;
      end if;

      while Found loop
         if Is_List_Present (Index) then
            Block := Free_List (Index.First_Level, Index.Second_Level);

            while Block /= null and then Memory.Size (Block) < Max_Size loop
               Block := Block.Akin.Next;
            end loop;

            if Block /= null then
               Delete_From_List (Block, Index);
               Set_Mark (Block.Near.Prev, False);  --  Mark as used

               if Memory.Size (Block) - Max_Size >= Threshold then
                  Split_Block (Block, Max_Size);
               end if;

               return Block.Data'Address;
            end if;
         end if;

         Find_Next_List (Index, Found);
      end loop;

      --  The heap is exhausted. Request a new block from the environment.
      declare
         Request : constant size_t :=
           size_t'Max (Raw_Alloc_Limit, Max_Size + Header_Size);
      begin
         if Last_Block = null then
            --  First request, data structure is not initialized.
            --  Find out the memory limit and set the block size accordingly.
            Heap_Base.Near.Next := Block_Reference (Low_Level_Allocation (0));

            Block := Heap_Base'Access;
         else
            Block := To_Block (Last_Block.Near.Next);

            Block.Near.Next :=
              Block_Reference (Low_Level_Allocation (Request));

            if Block.Near.Next = 0 then
               --  The environment doesn't provide a new memory. Return null
               return System.Null_Address;
            end if;

            Last_Block.Near.Next := To_Reference (Block);
            Block.Near.Prev := To_Reference (Last_Block);
         end if;

         Last_Block := Block;
         Set_Mark (Block.Near.Next, True);  --  Mark as Is_Last_Block
         Free (Cast.To_Address (Cast.Object_Pointer (Block)) + Header_Size);
         --  Append block to the free lists.

         return Alloc (Size);
      end;
   end Alloc;

   --------------------
   -- Append_To_List --
   --------------------

   procedure Append_To_List (Block : Block_Access) is
      Index : constant List_Index := Get_List_Index (Size (Block));
      Head : constant Block_Access :=
        Free_List (Index.First_Level, Index.Second_Level);
   begin
      Block.Akin.Next := Head;
      Block.Akin.Prev := null;

      if Head = null then
         Set_List_Present (Index);
      else
         Head.Akin.Prev := Block;
      end if;

      Free_List (Index.First_Level, Index.Second_Level) := Block;
   end Append_To_List;

   --------------
   -- C_Calloc --
   --------------

   function C_Calloc
     (N_Elem : size_t; Elem_Size : size_t) return System.Address
   is
   begin
      return C_Malloc (N_Elem * Elem_Size);
   end C_Calloc;

   --------------
   -- C_Malloc --
   --------------

   function C_Malloc (Size : size_t) return System.Address is
   begin
      return Alloc (Size);
   end C_Malloc;

   ------------
   -- C_Free --
   ------------

   procedure C_Free (Ptr : System.Address) is
   begin
      Free (Ptr);
   end C_Free;

   ------------------------
   -- Cleat_List_Present --
   ------------------------

   procedure Cleat_List_Present (Index : List_Index) is
      Bit_Index : constant Interfaces.Unsigned_32 := Get_Bit_Index (Index);
   begin
      Bit_Map (Bit_Index / 64) := Bit_Map (Bit_Index / 64)
        and not Interfaces.Shift_Left (1, Natural (Bit_Index mod 64));
   end Cleat_List_Present;

   -------------------------
   -- Count_Leading_Zeros --
   -------------------------

   function Count_Leading_Zeros (Value : size_t) return Natural is
   begin
      System.Machine_Code.Asm
        ("local.get 0" & ASCII.LF & ASCII.HT &
         "i32.clz" & ASCII.LF & ASCII.HT &
         "return",
         Volatile => True);
      --  Now, return some dummy value to make the compiler happy
      return Natural (Value and 1);
   end Count_Leading_Zeros;

   --------------------------
   -- Count_Trailing_Zeros --
   --------------------------

   function Count_Trailing_Zeros
     (Value : Interfaces.Unsigned_64) return Interfaces.Unsigned_64 is
   begin
      System.Machine_Code.Asm
        ("local.get 0" & ASCII.LF & ASCII.HT &
         "i64.ctz" & ASCII.LF & ASCII.HT &
         "return",
         Volatile => True);
      --  Now, return some dummy value to make the compiler happy
      return Value and 1;
   end Count_Trailing_Zeros;

   ----------------------
   -- Delete_From_List --
   ----------------------

   procedure Delete_From_List (Block : Block_Access; Index : List_Index) is
   begin
      if Block.Akin.Prev = null then
         pragma Assert
           (Free_List (Index.First_Level, Index.Second_Level) = Block);

         Free_List (Index.First_Level, Index.Second_Level) := Block.Akin.Next;

         if Block.Akin.Next = null then
            Cleat_List_Present (Index);
         end if;
      else
         Block.Akin.Prev.Akin.Next := Block.Akin.Next;
      end if;

      if Block.Akin.Next /= null then
         Block.Akin.Next.Akin.Prev := Block.Akin.Prev;
      end if;
   end Delete_From_List;

   --------------------
   -- Find_Next_List --
   --------------------

   procedure Find_Next_List (Index : in out List_Index; Found : out Boolean) is
      Bit_Index  : Interfaces.Unsigned_32 := Get_Bit_Index (Index);
      Word_Index : Interfaces.Unsigned_32 := Bit_Index / 64;
      Word : Interfaces.Unsigned_64 := Bit_Map (Word_Index);
      Mask : constant Interfaces.Unsigned_64 :=
        not (Interfaces.Shift_Left (1, Natural (Bit_Index mod 64)) - 1);
   begin
      Word := Word and Interfaces.Shift_Left (Mask, 1);
      --  Clear this bit and anything lower that it

      loop
         if Word /= 0 then
            Found := True;

            Bit_Index := Word_Index * 64 +
              Interfaces.Unsigned_32 (Count_Trailing_Zeros (Word));

            Index.Second_Level := Second_Level_Index'Mod (Bit_Index);

            Index.First_Level :=
              First_Level_Index (Bit_Index / Second_Level_Index'Modulus);

            return;
         end if;

         Word_Index := Word_Index + 1;
         exit when Word_Index > Bit_Map'Last;
         Word := Bit_Map (Word_Index);
      end loop;

      Found := False;
   end Find_Next_List;

   ----------
   -- Free --
   ----------

   procedure Free (Ptr : System.Address) is
      Block_Addr : constant System.Address := Ptr - Header_Size;

      Block      : Block_Access :=
        Block_Access (Cast.To_Pointer (Block_Addr));

      Index      : List_Index;
      Left       : constant Block_Access := Prev (Block);
      Right      : constant Block_Access := Next (Block);
   begin
      if Ptr = System.Null_Address then
         return;

      elsif Left /= null and then Is_Free (Left) then
         Index := Get_List_Index (Size (Left));
         Delete_From_List (Left, Index);
         Left.Near.Next := Block.Near.Next;

         if Right = null then
            pragma Assert (Is_Marked (Block.Near.Next));
            pragma Assert (Last_Block = Block);
            Last_Block := Left;
         elsif not Is_Free (Right) then
            Right.Near.Prev := To_Reference (Left);
         end if;

         Block := Left;
      end if;

      if Right /= null and then Is_Free (Right) then
         Index := Get_List_Index (Size (Right));
         Delete_From_List (Right, Index);
         Block.Near.Next := Right.Near.Next;

         declare
            Right_Right : constant Block_Access := Next (Right);
         begin
            if Right_Right = null then
               pragma Assert (Is_Marked (Right.Near.Next));
               pragma Assert (Last_Block = Right);
               Last_Block := Block;
            else
               Right_Right.Near.Prev :=
                 To_Reference (Block, Is_Free (Right_Right));
            end if;
         end;
      end if;

      Append_To_List (Block);
      Set_Mark (Block.Near.Prev, True);
   end Free;

   --------------------
   -- Get_List_Index --
   --------------------

   function Get_List_Index (Value : size_t) return List_Index is
      use Interfaces;
      Group : First_Level_Index;  --  Group index
      Index : Second_Level_Index;  --  An index inside the group
      Shift : Natural := Addr_Size - 1 - Count_Leading_Zeros (Value);
   begin
      pragma Compile_Time_Error
        (Unsigned_32'Size /= Addr_Size,
         "Wrong address size");

      if Shift < Split_Bits + Align_Bits then
         Group := 0;
         --  Exact block size group
         Index := Second_Level_Index'Mod
           (Shift_Right (Unsigned_32 (Value), Align_Bits));
      else
         Shift := Shift - Split_Bits;
         Group := First_Level_Index (Shift - Align_Bits) + 1;
         Index := Second_Level_Index'Mod
           (Shift_Right (Unsigned_32 (Value), Shift));
      end if;

      return (First_Level => Group, Second_Level => Index);
   end Get_List_Index;

   ---------------
   -- Is_Marked --
   ---------------

   function Is_Marked (Value : Block_Reference) return Boolean is
   begin
      return (Value and 1) /= 0;
   end Is_Marked;

   ---------------------
   -- Is_List_Present --
   ---------------------

   function Is_List_Present (Index : List_Index) return Boolean is
      Bit_Index : constant Interfaces.Unsigned_32 := Get_Bit_Index (Index);
   begin
      return (Bit_Map (Bit_Index / 64)
        and Interfaces.Shift_Left (1, Natural (Bit_Index mod 64))) /= 0;
   end Is_List_Present;

   --------------------------
   -- Low_Level_Allocation --
   --------------------------

   function Low_Level_Allocation (Size : size_t) return System.Address is
      Page_Size : constant := 16#1_0000#;

      function gnat_grow
        (Pages : Interfaces.Unsigned_32) return Interfaces.Unsigned_32
           with Import, Convention => C, Link_Name => "__gnat_grow";

      Pages : Interfaces.Unsigned_32 := Interfaces.Unsigned_32
        ((Size + (Page_Size - 1)) / Page_Size);
   begin
      Pages := Pages + gnat_grow (Pages);

      return System.Address (Pages) * Page_Size;
   end Low_Level_Allocation;

   -------------
   -- Realloc --
   -------------

   function Realloc
     (Ptr  : System.Address;
      Size : size_t) return System.Address
   is
      Block_Addr : constant System.Address := Ptr - Header_Size;

      Block      : constant Block_Access :=
        Block_Access (Cast.To_Pointer (Block_Addr));
   begin
      if Size <= Memory.Size (Block) then
         return Ptr;
      else
         return System.Null_Address;
      end if;
   end Realloc;

   --------------
   -- Set_Mark --
   --------------

   procedure Set_Mark
     (Value : in out Block_Reference;
      Mark  : Boolean := True) is
   begin
      Value := (Value and not 1) or Boolean'Pos (Mark);
   end Set_Mark;

   ----------------------
   -- Set_List_Present --
   ----------------------

   procedure Set_List_Present (Index : List_Index) is
      Bit_Index : constant Interfaces.Unsigned_32 := Get_Bit_Index (Index);
   begin
      Bit_Map (Bit_Index / 64) := Bit_Map (Bit_Index / 64)
        or Interfaces.Shift_Left (1, Natural (Bit_Index mod 64));
   end Set_List_Present;

   ----------
   -- Size --
   ----------

   function Size (Value : not null Block_Access) return size_t is
   begin
      return size_t ((Value.Near.Next and not 1) - To_Reference (Value))
        - Header_Size;
   end Size;

   -----------------
   -- Split_Block --
   -----------------

   procedure Split_Block (Block : not null Block_Access; Size : size_t) is
      Rest : constant Block_Access :=
        To_Block (To_Reference (Block) + Block_Reference (Size + Header_Size));
      Right : constant Block_Access := Next (Block);
   begin
      if Right = null then
         pragma Assert (Last_Block = Block);
         Last_Block := Rest;
      else
         Right.Near.Prev := To_Reference (Rest, Is_Marked (Right.Near.Prev));
      end if;

      Rest.Near.Next := Block.Near.Next;

      Block.Near.Next := To_Reference (Rest);
      Rest.Near.Prev := To_Reference (Block, True);  --  Is_Free

      Append_To_List (Rest);
   end Split_Block;

   --------------
   -- To_Block --
   --------------

   function To_Block (Value : Block_Reference) return Block_Access is
      Addr : constant System.Address := System.Address (Value and not 1);
   begin
      return Block_Access (Cast.To_Pointer (Addr));
   end To_Block;

   ------------------
   -- To_Reference --
   ------------------

   function To_Reference
     (Value : not null Block_Access;
      Mark  : Boolean := False) return Block_Reference
   is
      Addr : constant System.Address :=
        Cast.To_Address (Cast.Object_Pointer (Value));
   begin
      return Block_Reference (Addr) or Boolean'Pos (Mark);
   end To_Reference;

end System.Memory;
