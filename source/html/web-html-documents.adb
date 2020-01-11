
with Interfaces;
with System;

with WASM.Objects;

with Web.DOM.Elements;
with Web.Strings.WASM_Helpers;

package body Web.HTML.Documents is

   -----------------------
   -- Get_Element_By_Id --
   -----------------------

--  XXX This implementation results in wrong code, thus rewritten below
--
--   function Get_Element_By_Id
--    (Self       : Document'Class;
--     Element_Id : Web.Strings.Web_String)
--       return Web.HTML.Elements.HTML_Element is
--   begin
--      return
--        Web.HTML.Elements.Instantiate
--         (Web.DOM.Elements.Element'
--           (Self.Get_Element_By_Id (Element_Id)).Identifier);
--   end Get_Element_By_Id;

   function Get_Element_By_Id
    (Self       : Document'Class;
     Element_Id : Web.Strings.Web_String)
       return Web.HTML.Elements.HTML_Element
   is
      function Internal
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Length     : Interfaces.Unsigned_32)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Link_Name => "__adawebpack__dom__document__getElementById";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Element_Id, A, S);

      return Web.HTML.Elements.Instantiate (Internal (Self.Identifier, A, S));
   end Get_Element_By_Id;

end Web.HTML.Documents;
