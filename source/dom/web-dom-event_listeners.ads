
with Web.DOM.Events;

package Web.DOM.Event_Listeners is

   pragma Preelaborate;

   type Event_Listener is limited interface;

   type Event_Listener_Access is access all Event_Listener'Class;

   not overriding procedure Handle_Event
    (Self  : in out Event_Listener;
     Event : in out Web.DOM.Events.Event'Class) is abstract;

end Web.DOM.Event_Listeners;
