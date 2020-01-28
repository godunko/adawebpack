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

--  Simple implementation for use with LLVM/WASM

pragma Restrictions (No_Elaboration_Code);
--  This unit may be linked without being with'ed, so we need to ensure
--  there is no elaboration code (since this code might not be executed).

with System.Address_To_Access_Conversions;
with System.Storage_Elements;

package body System.Memory is

   use System.Storage_Elements;

   Metadata_Size : constant Storage_Count := 16;

   type Metadata;

   type Metadata_Access is access all Metadata;

   pragma Warnings (Off);
   type Metadata is record
      Capacity : Storage_Count;
      Next     : Metadata_Access;
      Is_Free  : Boolean;
   end record
     with Size => Standard'Storage_Unit * Metadata_Size;
   pragma Warnings (On);

   package Metadata_Access_To_Address_Conversions is
     new System.Address_To_Access_Conversions (Metadata);

   function To_Address (Item : Metadata_Access) return System.Address
     is (Metadata_Access_To_Address_Conversions.To_Address
          (Metadata_Access_To_Address_Conversions.Object_Pointer (Item)));

   function To_Access (Item : System.Address) return Metadata_Access
     is (Metadata_Access
          (Metadata_Access_To_Address_Conversions.To_Pointer (Item)));

   Heap_Base : aliased Metadata
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
      Max_Size  : Storage_Count;
      Res       : Address := Null_Address;

   begin
      if Size = 0 then

         --  Change size from zero to nonzero. We still want a proper pointer
         --  for the zero case because pointers to zero-length objects have to
         --  be distinct.

         Max_Size := Max_Align;

      else
         --  Detect overflow in the addition below. Note that we know that
         --  upper bound of size_t is bigger than the upper bound of
         --  Storage_Count.

         if Size > size_t (Storage_Count'Last - Max_Align) then
            raise Storage_Error;
         end if;

         --  Compute aligned size

         Max_Size :=
           ((Storage_Count (Size) + Max_Align - 1) / Max_Align) * Max_Align;
      end if;

      if Heap_Base.Capacity = 0 then
         --  First request, data structure is not initialized.

         Heap_Base := (Capacity => Max_Size, Next => null, Is_Free => False);
         Res := Heap_Base'Address + Metadata_Size;

      else
         declare
            Current : Metadata_Access := Heap_Base'Access;
            Last    : Metadata_Access;

         begin
            while Current /= null loop
               if Current.Is_Free and Current.Capacity >= Max_Size then
                  --  Reuse existing block.

                  Current.Is_Free := False;
                  Res := To_Address (Current) + Metadata_Size;

                  exit;
               end if;

               Last    := Current;
               Current := Current.Next;
            end loop;

            if Res = Null_Address then
               --  Allocate new block.

               Current :=
                 To_Access (To_Address (Last) + Metadata_Size + Last.Capacity);
               Last.Next := Current;

               Current.all :=
                (Capacity => Max_Size, Next => null, Is_Free => False);
               Res := To_Address (Current) + Metadata_Size;
            end if;
         end;
      end if;

      return Res;
   end Alloc;

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

   ----------
   -- Free --
   ----------

   procedure Free (Ptr : System.Address) is
      Header : constant Metadata_Access := To_Access (Ptr - Metadata_Size);

   begin
      Header.Is_Free := True;
   end Free;

   -------------
   -- Realloc --
   -------------

   function Realloc
     (Ptr  : System.Address;
      Size : size_t) return System.Address
   is
      pragma Unreferenced (Ptr);
      pragma Unreferenced (Size);

   begin
      return System.Null_Address;
   end Realloc;

end System.Memory;
