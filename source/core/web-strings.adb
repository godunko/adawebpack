------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2020, Vadim Godunko                                         --
--  All rights reserved.                                                    --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--                                                                          --
--  1. Redistributions of source code must retain the above copyright       --
--     notice, this list of conditions and the following disclaimer.        --
--                                                                          --
--  2. Redistributions in binary form must reproduce the above copyright    --
--     notice, this list of conditions and the following disclaimer in the  --
--     documentation and/or other materials provided with the distribution. --
--                                                                          --
--  3. Neither the name of the copyright holder nor the names of its        --
--     contributors may be used to endorse or promote products derived      --
--     from this software without specific prior written permission.        --
--                                                                          --
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS     --
--  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT       --
--  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR   --
--  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT    --
--  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,  --
--  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT        --
--  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,   --
--  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY   --
--  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT     --
--  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE   --
--  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.    --
------------------------------------------------------------------------------

with Ada.Unchecked_Deallocation;

package body Web.Strings is

   use type Interfaces.Unsigned_32;

   --  Surrogate ranges.

   Surrogate_First      : constant := 16#D800#;
   High_Surrogate_First : constant := 16#D800#;
   High_Surrogate_Last  : constant := 16#DBFF#;
   Low_Surrogate_First  : constant := 16#DC00#;
   Low_Surrogate_Last   : constant := 16#DFFF#;
   Surrogate_Last       : constant := 16#DFFF#;

   High_Surrogate_First_Store : constant
     := High_Surrogate_First - 16#1_0000# / 16#400#;
   --  Code point is converted to surrogate pair as:
   --
   --  S (J)     := HB + (C - 0x10000) >> 10
   --  S (J + 1) := LB + (C - 0x10000) & 0x3FF
   --
   --  to optimize implementation they are rewritten as:
   --
   --  S (J + 1) := LB + C & 0x3FF
   --  S (J)     := (HB - 0x10000 >> 10) + C >> 10
   --               ^^^^^^^^^^^^^^^^^^^^
   --  This constant represents constant part of the expression.

   Surrogate_Kind_Mask   : constant := 16#FC00#;
   Masked_High_Surrogate : constant := 16#D800#;

   UCS4_Fixup : constant
     := High_Surrogate_First * 16#400# + Low_Surrogate_First - 16#1_0000#;
   --  When code point is encoded as pair of surrogates its value computed as:
   --
   --    C := (S (J) - HB) << 10 + S (J + 1) - LB + 0x10000
   --
   --  to optimize number of computations this expression is transformed to
   --
   --    C := S (J) << 10 + S (J + 1) - (HB << 10 + LB - 0x10000)
   --                                   ^^^^^^^^^^^^^^^^^^^^^^^^^
   --  This constant represents constant part of the expression.

   procedure Release (Item : in out String_Data_Access);

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Web_String) is
   begin
      if Self.Data /= null then
         Self.Data.Counter := Self.Data.Counter + 1;
      end if;
   end Adjust;

   -----------
   -- Clear --
   -----------

   procedure Clear (Self : in out Web_String'Class) is
   begin
      Release (Self.Data);
   end Clear;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Web_String) is
   begin
      Release (Self.Data);
   end Finalize;

   --------------
   -- Is_Empty --
   --------------

   function Is_Empty (Self : Web_String'Class) return Boolean is
   begin
      return Self.Data = null or else Self.Data.Length = 0;
   end Is_Empty;

   ------------
   -- Length --
   ------------

   function Length (Self : Web_String'Class) return Natural is
   begin
      return (if Self.Data = null then 0 else Self.Data.Length);
   end Length;

   -------------
   -- Release --
   -------------

   procedure Release (Item : in out String_Data_Access) is
      procedure Free is
        new Ada.Unchecked_Deallocation (String_Data, String_Data_Access);

   begin
      if Item /= null then
         Item.Counter := Item.Counter - 1;

         if Item.Counter = 0 then
            Free (Item);

         else
            Item := null;
         end if;
      end if;
   end Release;

   -------------------
   -- To_Web_String --
   -------------------

   function To_Web_String (Item : Wide_Wide_String) return Web_String is
      use type Web.Unicode.Unicode_Code_Point;

      Code : Web.Unicode.Unicode_Code_Point;

   begin
      return Result : Web_String
        := (Ada.Finalization.Controlled with
              Data => new String_Data (Item'Length))
      do
         Result.Data.Size := 0;

         for C of Item loop
            Code := Wide_Wide_Character'Pos (C);

            if Code <= 16#FFFF# then
               Result.Data.Data (Result.Data.Size) := Web.Unicode.UTF16_Code_Unit (Code);
               Result.Data.Size := Result.Data.Size + 1;

            else
               Result.Data.Data (Result.Data.Size) :=
                 Web.Unicode.UTF16_Code_Unit
                  (High_Surrogate_First_Store + Code / 16#400#);
               Result.Data.Data (Result.Data.Size + 1) :=
                 Web.Unicode.UTF16_Code_Unit
                  (Low_Surrogate_First + Code mod 16#400#);
               Result.Data.Size := Result.Data.Size + 2;
            end if;
         end loop;
      end return;
   end To_Web_String;

   -------------------------
   -- To_Wide_Wide_String --
   -------------------------

   function To_Wide_Wide_String (Self : Web_String) return Wide_Wide_String is
      use type Web.Unicode.Unicode_Code_Point;

      Code  : Web.Unicode.Unicode_Code_Point;
      Index : Interfaces.Unsigned_32 := 0;

   begin
      return Result : Wide_Wide_String (1 .. Self.Length) do
         for J in Result'Range loop
            Code := Web.Unicode.Unicode_Code_Point (Self.Data.Data (Index));
            Index := Index + 1;

            if (Code and Surrogate_Kind_Mask) = Masked_High_Surrogate then
               Code :=
                 Code * 16#400#
                   + Web.Unicode.Unicode_Code_Point (Self.Data.Data (Index))
                   - UCS4_Fixup;
               Index := Index + 1;
            end if;

            Result (J) := Wide_Wide_Character'Val (Code);
         end loop;
      end return;
   end To_Wide_Wide_String;

end Web.Strings;
