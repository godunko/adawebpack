--  Package to process strings.

private with Ada.Finalization;
private with Interfaces;

private with Web.Unicode;

package Web.Strings is

   pragma Preelaborate;

   type Web_String is tagged private;

   function To_Web_String (Item : Wide_Wide_String) return Web_String;

private

   type String_Data (Capacity : Interfaces.Unsigned_32) is record
      Counter : Interfaces.Unsigned_32 := 1;
      Size    : Interfaces.Unsigned_32;
      Length  : Natural;
      Data    : Web.Unicode.UTF16_Code_Unit_Array (0 .. Capacity);
   end record;

   type String_Data_Access is access all String_Data;

   type Web_String is new Ada.Finalization.Controlled with record
      Data : String_Data_Access;
   end record;

   overriding procedure Adjust (Self : in out Web_String);
   overriding procedure Finalize (Self : in out Web_String);

end Web.Strings;
