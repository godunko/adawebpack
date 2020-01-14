
with Interfaces;
with System;

with WASM.Objects;
with Web.Strings.WASM_Helpers;

package body Web.DOM.Documents is

   -----------------------
   -- Get_Element_By_Id --
   -----------------------

   overriding function Get_Element_By_Id
    (Self       : Document;
     Element_Id : Web.Strings.Web_String) return Web.DOM.Elements.Element
   is
      function Internal
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Length     : Interfaces.Unsigned_32)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Link_Name => "__adawebpack__dom__Document__getElementById";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Element_Id, A, S);

      return Web.DOM.Elements.Instantiate (Internal (Self.Identifier, A, S));
   end Get_Element_By_Id;

end Web.DOM.Documents;
