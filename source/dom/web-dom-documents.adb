
with Interfaces;
with System;

with WASM.Objects;
with WASM.Strings;

package body Web.DOM.Documents is

   -----------------------
   -- Get_Element_By_Id --
   -----------------------

   overriding function Get_Element_By_Id
    (Self       : Document;
     Element_Id : Wide_String) return Web.DOM.Elements.Element
   is
      function Internal
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Length     : Interfaces.Unsigned_32)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Link_Name => "__adawebpack__dom__document__getElementById";

      A : System.Address;
      L : Interfaces.Unsigned_32;

   begin
      WASM.Strings.To_JS (Element_Id, A, L);

      return Result : Web.DOM.Elements.Element
        := Web.DOM.Elements.Instantiate (Internal (Self.Identifier, A, L))
      do
         WASM.Strings.Release (A, L);
      end return;
   end Get_Element_By_Id;

end Web.DOM.Documents;
