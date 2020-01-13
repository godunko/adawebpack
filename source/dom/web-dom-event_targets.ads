
with Web.DOM.Event_Listeners;
with Web.Strings;

package Web.DOM.Event_Targets is

   pragma Preelaborate;

   type Event_Target is limited interface;

   not overriding procedure Add_Event_Listener
    (Self     : in out Event_Target;
     Name     : Web.Strings.Web_String;
     Callback : not null Web.DOM.Event_Listeners.Event_Listener_Access;
     Capture  : Boolean := False) is abstract;

end Web.DOM.Event_Targets;
