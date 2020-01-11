--  Internal package for interfacing between JavaScript and WASM.

with Interfaces;
with System;

package Web.Strings.WASM_Helpers is

   pragma Preelaborate;

   procedure To_JS
    (Item    : Web_String;
     Address : out System.Address;
     Size    : out Interfaces.Unsigned_32);
   --  Returns address and size of the string data for given string object.
   --  Address is valid till string object exists and immutable.

end Web.Strings.WASM_Helpers;
