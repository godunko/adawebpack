
with Web.DOM.Elements;

package Web.HTML.Elements is

   type HTML_Element is new Web.DOM.Elements.Element with null record;

   procedure Set_Hidden (Self : in out HTML_Element'Class; To : Boolean);

end Web.HTML.Elements;
