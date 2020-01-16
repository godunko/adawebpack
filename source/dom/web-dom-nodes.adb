
with Ada.Unchecked_Conversion;
with Interfaces;
with System;

with Web.DOM.Events;
with Web.Strings.WASM_Helpers;

package body Web.DOM.Nodes is

   procedure Dispatch_Event
    (Callback   : System.Address;
     Identifier : WASM.Objects.Object_Identifier)
      with Export     => True,
           Convention => C,
           Link_Name  => "__adawebpack__dom__Node__dispatch_event";

   ------------------------
   -- Add_Event_Listener --
   ------------------------

   overriding procedure Add_Event_Listener
    (Self     : in out Node;
     Name     : Web.Strings.Web_String;
     Callback : not null Web.DOM.Event_Listeners.Event_Listener_Access;
     Capture  : Boolean := False)
   is
      procedure Imported
       (Identifier   : WASM.Objects.Object_Identifier;
        Name_Address : System.Address;
        Name_Size    : Interfaces.Unsigned_32;
        Callback     : System.Address;
        Capture      : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__dom__Node__addEventListener";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Name, A, S);
      Imported
       (Self.Identifier, A, S, Callback.all'Address, (if Capture then 1 else 0));
   end Add_Event_Listener;

   function To_Object is
     new Ada.Unchecked_Conversion (System.Address, Web.DOM.Event_Listeners.Event_Listener_Access);

   --------------------
   -- Dispatch_Event --
   --------------------

   procedure Dispatch_Event
    (Callback   : System.Address;
     Identifier : WASM.Objects.Object_Identifier)
   is
      E : Web.DOM.Events.Event;
--      C : Web.DOM.Event_Listeners.Event_Listener
--        with Import => True;
-- , Address => Callback;

   begin
--      Web.DOM.Event_Listeners.Event_Listener'Class (C).Handle_Event (E);
      To_Object (Callback).Handle_Event (E);
   end Dispatch_Event;

end Web.DOM.Nodes;
