
with Interfaces;

with WASM.Objects;

package body Web.HTML.Elements is

   ----------------
   -- Get_Hidden --
   ----------------

   function Get_Hidden (Self : HTML_Element'Class) return Boolean is
      use type Interfaces.Unsigned_32;

      function Imported
       (Element : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import    => True,
                 Link_Name => "__adawebpack__html__Element__hidden_getter";
   begin
      return Imported (Self.Identifier) /= 0;
   end Get_Hidden;

   ----------------
   -- Set_Hidden --
   ----------------

   procedure Set_Hidden (Self : in out HTML_Element'Class; To : Boolean) is
      procedure Imported
       (Element : WASM.Objects.Object_Identifier; To : Interfaces.Unsigned_32)
          with Import    => True,
               Link_Name => "__adawebpack__html__Element__hidden_setter";

   begin
      Imported (Self.Identifier, Boolean'Pos (To));
   end Set_Hidden;

end Web.HTML.Elements;
