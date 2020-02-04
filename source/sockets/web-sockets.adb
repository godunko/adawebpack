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

with System;

with Web.Strings.WASM_Helpers;

package body Web.Sockets is

   ------------------------
   -- Add_Event_Listener --
   ------------------------

   overriding procedure Add_Event_Listener
    (Self     : in out Web_Socket;
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
       (Self.Identifier, A, S, Callback.all'Address,
        (if Capture then 1 else 0));
   end Add_Event_Listener;

   -----------
   -- Close --
   -----------

   procedure Close (Self : in out Web_Socket'Class) is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__sockets__WebSocket__close";
   begin
      Imported (Self.Identifier);
   end Close;

   ------------
   -- Create --
   ------------

   function Create (URL : Web.Strings.Web_String) return Web_Socket is
      function Internal
       (Address : System.Address;
        Length  : Interfaces.Unsigned_32)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__sockets__WebSocket__create";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (URL, A, S);

      return Web.Sockets.Instantiate (Internal (A, S));
   end Create;

   ---------------------
   -- Get_Binary_Type --
   ---------------------

   function Get_Binary_Type (Self : Web_Socket'Class) return Binary_Type is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__sockets__WebSocket__get_bin_type";
   begin
      return (if Imported (Self.Identifier) in 0 then blob else arraybuffer);
   end Get_Binary_Type;

   -------------------------
   -- Get_Buffered_Amount --
   -------------------------

   function Get_Buffered_Amount
     (Self : Web_Socket'Class) return Ada.Streams.Stream_Element_Count
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return Ada.Streams.Stream_Element_Count
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__sockets__WebSocket__buf_amount";
   begin
      return Imported (Self.Identifier);
   end Get_Buffered_Amount;

   --------------------
   -- Get_Extensions --
   --------------------

   function Get_Extensions
     (Self : Web_Socket'Class) return Web.Strings.Web_String
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__sockets__WebSocket__get_ext";

   begin
      return Web.Strings.WASM_Helpers.To_Ada (Imported (Self.Identifier));
   end Get_Extensions;

   ------------------
   -- Get_Protocol --
   ------------------

   function Get_Protocol
     (Self : Web_Socket'Class) return Web.Strings.Web_String
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__sockets__WebSocket__get_proto";

   begin
      return Web.Strings.WASM_Helpers.To_Ada (Imported (Self.Identifier));
   end Get_Protocol;

   ---------------------
   -- Get_Ready_State --
   ---------------------

   function Get_Ready_State (Self : Web_Socket'Class) return State is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return state
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__sockets__WebSocket__get_state";
   begin
      return Imported (Self.Identifier);
   end Get_Ready_State;

   -------------
   -- Get_URL --
   -------------

   function Get_URL (Self : Web_Socket'Class) return Web.Strings.Web_String is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__sockets__WebSocket__get_url";

   begin
      return Web.Strings.WASM_Helpers.To_Ada (Imported (Self.Identifier));
   end Get_URL;

   ----------
   -- Send --
   ----------

   procedure Send
    (Self : in out Web_Socket'Class;
     Data : Web.Strings.Web_String)
   is
      procedure Imported
       (Identifier   : WASM.Objects.Object_Identifier;
        Text_Address : System.Address;
        Text_Size    : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__sockets__WebSocket__send_str";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Data, A, S);
      Imported (Self.Identifier, A, S);
   end Send;

   ----------
   -- Send --
   ----------

   procedure Send
    (Self : in out Web_Socket'Class;
     Data : Ada.Streams.Stream_Element_Array)
   is
      procedure Imported
       (Identifier   : WASM.Objects.Object_Identifier;
        Data_Address : System.Address;
        Data_Size    : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__sockets__WebSocket__send_bin";

   begin
      Imported (Self.Identifier, Data'Address, Data'Length);
   end Send;

   ---------------------
   -- Set_Binary_Type --
   ---------------------

   procedure Set_Binary_Type
    (Self  : in out Web_Socket'Class;
     Value : Binary_Type)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Value      : Interfaces.Unsigned_32)
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__sockets__WebSocket__set_bin_type";
   begin
      Imported (Self.Identifier, Binary_Type'Pos (Value));
   end Set_Binary_Type;

end Web.Sockets;
