
package body WASM.Strings is

   subtype Big_Wide_String is Wide_String (1 .. Integer'Last);

   type Big_Wide_String_Access is access all Big_Wide_String;
   --  To simplify conversion Wide_String is used because it has same
   --  representation with JavaScript strings.

   type Wide_String_Access is access all Wide_String;

   -------------
   -- Release --
   -------------

   procedure Release
     (Data   : in out System.Address;
      Length : in out Interfaces.Unsigned_32) is
   begin
      Data   := System.Null_Address;
      Length := 0;
   end Release;

   -----------
   -- To_JS --
   -----------

   procedure To_JS
     (Item   : Wide_String;
      Data   : out System.Address;
      Length : out Interfaces.Unsigned_32)
   is
      Aux : constant Wide_String_Access := new Wide_String'(Item);

   begin
      Length := Item'Length;
      Data   := Aux.all'Address;
   end To_JS;
   
end WASM.Strings;
