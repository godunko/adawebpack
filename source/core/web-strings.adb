
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

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Web_String) is
   begin
      if Self.Data /= null then
         Self.Data.Counter := Self.Data.Counter + 1;
      end if;
   end Adjust;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Web_String) is
      procedure Free is
        new Ada.Unchecked_Deallocation (String_Data, String_Data_Access);

   begin
      if Self.Data /= null then
         Self.Data.Counter := Self.Data.Counter - 1;

         if Self.Data.Counter = 0 then
            Free (Self.Data);
         end if;

         Self.Data := null;
      end if;
   end Finalize;

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

end Web.Strings;
