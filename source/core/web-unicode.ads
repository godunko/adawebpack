--  Internal root package for Unicode support

with Interfaces;

package Web.Unicode is

   pragma Pure;

   type Unicode_Code_Point is
     new Interfaces.Unsigned_32 range 16#00_0000# .. 16#10_FFFF#;

   -----------
   -- UTF16 --
   -----------

   type UTF16_Code_Unit is new Interfaces.Unsigned_16;

   type UTF16_Code_Unit_Array is
     array (Interfaces.Unsigned_32 range <>) of UTF16_Code_Unit;

end Web.Unicode;
