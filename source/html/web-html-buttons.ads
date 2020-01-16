
with Web.HTML.Elements;

package Web.HTML.Buttons is

   type HTML_Button is new Web.HTML.Elements.HTML_Element with null record;

   function Get_Disabled (Self : HTML_Button'Class) return Boolean;
   procedure Set_Disabled (Self : in out HTML_Button'Class; To : Boolean);
   --   Whether the form control is disabled

end Web.HTML.Buttons;
