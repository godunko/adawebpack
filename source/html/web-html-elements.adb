
with Interfaces;

with WASM.Objects;

package body Web.HTML.Elements is

   procedure Set_Hidden (Element : WASM.Objects.Object_Identifier; To : Interfaces.Unsigned_32)
     with Import    => True,
          Link_Name => "__html_element_hidden_setter";

   ----------------
   -- Set_Hidden --
   ----------------

   procedure Set_Hidden (Self : in out HTML_Element'Class; To : Boolean) is
   begin
      Set_Hidden (Self.Identifier, Boolean'Pos (To));
   end Set_Hidden;

end Web.HTML.Elements;
