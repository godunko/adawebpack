
with Interfaces;

with WASM.Objects;

package body Web.HTML.Buttons is

   ------------------
   -- Get_Disabled --
   ------------------

   function Get_Disabled (Self : HTML_Button'Class) return Boolean is
      use type Interfaces.Unsigned_32;

      function Imported
       (Element : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import    => True,
                 Link_Name => "__adawebpack__html__Button__disabled_getter";
   begin
      return Imported (Self.Identifier) /= 0;
   end Get_Disabled;

   ------------------
   -- Set_Disabled --
   ------------------

   procedure Set_Disabled (Self : in out HTML_Button'Class; To : Boolean) is
      procedure Imported
       (Element : WASM.Objects.Object_Identifier; To : Interfaces.Unsigned_32)
          with Import    => True,
               Link_Name => "__adawebpack__html__Button__disabled_setter";

   begin
      Imported (Self.Identifier, Boolean'Pos (To));
   end Set_Disabled;

end Web.HTML.Buttons;
