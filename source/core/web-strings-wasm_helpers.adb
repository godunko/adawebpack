
package body Web.Strings.WASM_Helpers is

   -----------
   -- To_JS --
   -----------

   procedure To_JS
    (Item    : Web_String;
     Address : out System.Address;
     Size    : out Interfaces.Unsigned_32) is
   begin
      if Item.Data = null then
         Address := System.Null_Address;
         Size    := 0;

      else
         Address := Item.Data.Data (Item.Data.Data'First)'Address;
         Size    := Item.Data.Size;
      end if;
   end To_JS;

end Web.Strings.WASM_Helpers;
