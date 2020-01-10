--  Low level support for passing string data

with Interfaces;
with System;

package WASM.Strings is

   pragma Preelaborate;

   procedure To_JS
     (Item   : Wide_String;
      Data   : out System.Address;
      Length : out Interfaces.Unsigned_32);

   procedure Release
     (Data   : in out System.Address;
      Length : in out Interfaces.Unsigned_32);

end WASM.Strings;
