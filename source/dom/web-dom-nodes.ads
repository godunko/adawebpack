
with WASM.Objects;

with Web.DOM.Event_Listeners;
with Web.DOM.Event_Targets;
with Web.Strings;

package Web.DOM.Nodes is

   pragma Preelaborate;

   type Node is new WASM.Objects.Object_Reference
     and Web.DOM.Event_Targets.Event_Target with null record;

   overriding procedure Add_Event_Listener
    (Self     : in out Node;
     Name     : Web.Strings.Web_String;
     Callback : not null Web.DOM.Event_Listeners.Event_Listener_Access;
     Capture  : Boolean := False);

end Web.DOM.Nodes;
