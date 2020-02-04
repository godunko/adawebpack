------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2020, Vadim Godunko                                         --
--  All rights reserved.                                                    --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--                                                                          --
--  1. Redistributions of source code must retain the above copyright       --
--     notice, this list of conditions and the following disclaimer.        --
--                                                                          --
--  2. Redistributions in binary form must reproduce the above copyright    --
--     notice, this list of conditions and the following disclaimer in the  --
--     documentation and/or other materials provided with the distribution. --
--                                                                          --
--  3. Neither the name of the copyright holder nor the names of its        --
--     contributors may be used to endorse or promote products derived      --
--     from this software without specific prior written permission.        --
--                                                                          --
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS     --
--  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT       --
--  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR   --
--  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT    --
--  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,  --
--  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT        --
--  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,   --
--  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY   --
--  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT     --
--  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE   --
--  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.    --
------------------------------------------------------------------------------

with Ada.Streams;

with WASM.Objects;
with Web.DOM.Event_Listeners;
with Web.DOM.Event_Targets;
with Web.Strings;

package Web.Sockets is

   pragma Preelaborate;

   type Web_Socket is new WASM.Objects.Object_Reference
     and Web.DOM.Event_Targets.Event_Target
       with null record;

   overriding procedure Add_Event_Listener
    (Self     : in out Web_Socket;
     Name     : Web.Strings.Web_String;
     Callback : not null Web.DOM.Event_Listeners.Event_Listener_Access;
     Capture  : Boolean := False);

   function Create (URL : Web.Strings.Web_String) return Web_Socket;
   --  Creates a new WebSocket object, immediately establishing the associated
   --  WebSocket connection.
   --
   --  URL is a string giving the URL over which the connection is established.
   --  Only "ws" or "wss" schemes are allowed; others will cause a
   --  "SyntaxError" DOMException. URLs with fragments will also cause such an
   --  exception.

   function Get_URL (Self : Web_Socket'Class) return Web.Strings.Web_String;
   --  Returns the URL that was used to establish the WebSocket connection.

   type State is
     (CONNECTING,  --  The connection has not yet been established.

      OPEN,        --  The WebSocket connection is established and
                   --  communication is possible.

      CLOSING,     --  The connection is going through the closing handshake,
                   --  or the close () method has been invoked.

      CLOSED);     --  The connection has been closed or could not be opened.
   for State use (CONNECTING => 0, OPEN => 1, CLOSING => 2, CLOSED => 3);

   function Get_Ready_State (Self : Web_Socket'Class) return State;
   -- Returns the state of the WebSocket object's connection. It can have the
   -- values described below.

   function Get_Buffered_Amount
    (Self : Web_Socket'Class) return Ada.Streams.Stream_Element_Count;
   --  Returns the number of bytes of application data (UTF-8 text and binary
   --  data) that have been queued using send() but not yet been transmitted
   --  to the network.
   --
   --  If the WebSocket connection is closed, this attribute's value will only
   --  increase with each call to the send() method. (The number does not reset
   --  to zero once the connection closes.)

   function Get_Extensions
    (Self : Web_Socket'Class) return Web.Strings.Web_String;
   --  Returns the extensions selected by the server, if any.

   function Get_Protocol
    (Self : Web_Socket'Class) return Web.Strings.Web_String;
   --  Returns the subprotocol selected by the server, if any. It can be used
   --  in conjunction with the array form of the constructor's second argument
   --  to perform subprotocol negotiation.

   procedure Close (Self : in out Web_Socket'Class);
   --  Closes the WebSocket connection, optionally using code as the the
   --  WebSocket connection close code and reason as the the WebSocket
   --  connection close reason.

   type Binary_Type is (blob, arraybuffer);
   --  * "blob" - Binary data is returned in Blob form.
   --  * "arraybuffer" - Binary data is returned in ArrayBuffer form.

   function Get_Binary_Type (Self : Web_Socket'Class) return Binary_Type;
   --  Returns a string that indicates how binary data from the WebSocket
   --  object is exposed to scripts.
   --
   --  Can be set, to change how binary data is returned. The default is blob.

   procedure Set_Binary_Type
    (Self  : in out Web_Socket'Class;
     Value : Binary_Type);

   procedure Send
    (Self : in out Web_Socket'Class;
     Data : Web.Strings.Web_String);
   --  Transmits data using the WebSocket connection. data can be a string, a
   --  Blob, an ArrayBuffer, or an ArrayBufferView.

   procedure Send
    (Self : in out Web_Socket'Class;
     Data : Ada.Streams.Stream_Element_Array);
   --  The same for binary data

end Web.Sockets;
