
with Web.DOM.Event_Listeners;
with Web.DOM.Events;
with Web.HTML.Buttons;
with Web.HTML.Elements;
with Web.Strings;
with Web.Window;

package body Demo is

   function "+" (Item : Wide_Wide_String) return Web.Strings.Web_String
     renames Web.Strings.To_Web_String;

   type Listener is
     limited new Web.DOM.Event_Listeners.Event_Listener with null record;

   overriding procedure Handle_Event
    (Self  : in out Listener;
     Event : in out Web.DOM.Events.Event'Class);

   L : aliased Listener;

   ------------------
   -- Handle_Event --
   ------------------

   overriding procedure Handle_Event
    (Self  : in out Listener;
     Event : in out Web.DOM.Events.Event'Class)
   is
      X : Web.HTML.Elements.HTML_Element
        := Web.Window.Document.Get_Element_By_Id (+"toggle_label");

   begin
      X.Set_Hidden (not X.Get_Hidden);
   end Handle_Event;

   ---------------------
   -- Initialize_Demo --
   ---------------------

   procedure Initialize_Demo is
      B : Web.HTML.Buttons.HTML_Button_Element
        := Web.Window.Document.Get_Element_By_Id
            (+"toggle_button").As_HTML_Button;

   begin
      B.Add_Event_Listener (+"click", L'Access);
      B.Set_Disabled (False);
   end Initialize_Demo;

begin
   Initialize_Demo;
end Demo;
