------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                            Web API Definition                            --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2020-2022, Vadim Godunko <vgodunko@gmail.com>                --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Vadim Godunko, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------

with Ada.Unchecked_Conversion;
with Ada.Unchecked_Deallocation;
with System.Storage_Elements;

with WASM.Classes;
with WASM.Methods;
with WASM.Objects.Constructors;
with WASM.Objects.Methods;

with Web.Strings.WASM_Helpers;

package body Web.XHR.Requests is

   type Stream_Element_Buffer (Capacity : Ada.Streams.Stream_Element_Offset) is
      record
         Size : Ada.Streams.Stream_Element_Offset;
         Data : Ada.Streams.Stream_Element_Array (0 .. Capacity);
      end record;

   type Stream_Element_Buffer_Access is access all Stream_Element_Buffer;

   function To_Ada
     (Item : System.Address) return Ada.Streams.Stream_Element_Array;

   function Allocate_Stream_Element_Buffer
    (Size : Interfaces.Unsigned_32) return System.Address
       with Export     => True,
            Convention => C,
            Link_Name  => "__adawebpack__core__allocate_stream_element_buffer";

   Dummy : Stream_Element_Buffer (1);

   ------------------------------------
   -- Allocate_Stream_Element_Buffer --
   ------------------------------------

   function Allocate_Stream_Element_Buffer
    (Size : Interfaces.Unsigned_32) return System.Address
   is
      Aux : constant Stream_Element_Buffer_Access
        := new Stream_Element_Buffer
                (Ada.Streams.Stream_Element_Offset (Size));

   begin
      Aux.Size := Ada.Streams.Stream_Element_Offset (Size);

      return Aux.all.Data'Address;
   end Allocate_Stream_Element_Buffer;

   ------------
   -- To_Ada --
   ------------

   function To_Ada
    (Item : System.Address) return Ada.Streams.Stream_Element_Array
   is
      use type Ada.Streams.Stream_Element_Offset;
      use type System.Address;
      use type System.Storage_Elements.Storage_Offset;

      function To_Data is
        new Ada.Unchecked_Conversion
             (System.Address, Stream_Element_Buffer_Access);

      procedure Free is
        new Ada.Unchecked_Deallocation
             (Stream_Element_Buffer, Stream_Element_Buffer_Access);

      Aux : Stream_Element_Buffer_Access := null;

   begin
      if Item /= System.Null_Address then
         Aux := To_Data (Item - Dummy.Data'Position);

         return Result : constant Ada.Streams.Stream_Element_Array
           := Aux.Data (0 .. Aux.Size - 1)
         do
            Free (Aux);
         end return;

      else
         return Result : Ada.Streams.Stream_Element_Array (1 .. 0);
      end if;
   end To_Ada;

   function "+" (Item : Wide_Wide_String) return Web.Strings.Web_String
     renames Web.Strings.To_Web_String;

   ------------------------
   -- Add_Event_Listener --
   ------------------------

   overriding procedure Add_Event_Listener
    (Self     : in out XML_Http_Request;
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

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      --------------------------
      -- New_XML_Http_Request --
      --------------------------

      function New_XML_Http_Request return XML_Http_Request is
      begin
         return
           Web.XHR.Requests.Instantiate
            (WASM.Objects.Constructors.New_Object
              (WASM.Classes.XML_Http_Request));
      end New_XML_Http_Request;

   end Constructors;

   ---------------------
   -- Get_Ready_State --
   ---------------------

   function Get_Ready_State (Self : XML_Http_Request'Class) return State is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__xhr__XMLHttpRequest__readyState_getter";

   begin
      return State (Imported (Self.Identifier));
   end Get_Ready_State;

   ------------------
   -- Get_Response --
   ------------------

   function Get_Response
    (Self : XML_Http_Request'Class) return Ada.Streams.Stream_Element_Array
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__xhr__XMLHttpRequest__response_getter_stream_element_buffer";

      Aux : System.Address := Imported (Self.Identifier);

   begin
      return To_Ada (Aux);
   end Get_Response;

   -----------------------
   -- Get_Response_Type --
   -----------------------

   function Get_Response_Type
    (Self : XML_Http_Request'Class) return Response_Type_Kind
   is
      use type Web.Strings.Web_String;

      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__xhr__XMLHttpRequest__responseType_getter";

      Aux : constant Web.Strings.Web_String
        := Web.Strings.WASM_Helpers.To_Ada (Imported (Self.Identifier));

   begin
      if Aux = +"" then
         return Default;

      elsif Aux = +"arraybuffer" then
         return Array_Buffer;

      elsif Aux = +"blob" then
         return Blob;

      elsif Aux = +"document" then
         return Document;

      elsif Aux = +"json" then
         return JSON;

      elsif Aux = +"text" then
         return Text;

      else
         raise Program_Error;
      end if;
   end Get_Response_Type;

   ----------------
   -- Get_Status --
   ----------------

   function Get_Status
    (Self : XML_Http_Request'Class) return Web.DOM_Unsigned_Short
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__xhr__XMLHttpRequest__status_getter";

   begin
      return Web.DOM_Unsigned_Short (Imported (Self.Identifier));
   end Get_Status;

   ----------
   -- Open --
   ----------

   procedure Open
     (Self     : XML_Http_Request'Class;
      Method   : Web.Strings.Web_String;
      URL      : Web.Strings.Web_String;
      Async    : Boolean := True;
      Username : Web.Strings.Web_String := Web.Strings.Empty_Web_String;
      Password : Web.Strings.Web_String := Web.Strings.Empty_Web_String)
   is
      procedure Imported
       (Identifier       : WASM.Objects.Object_Identifier;
        Method_Address   : System.Address;
        Method_Size      : Interfaces.Unsigned_32;
        URL_Address      : System.Address;
        URL_Size         : Interfaces.Unsigned_32;
        Async            : Interfaces.Unsigned_32;
        Username_Address : System.Address;
        Username_Size    : Interfaces.Unsigned_32;
        Password_Address : System.Address;
        Password_Size    : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__xhr__XMLHttpRequest__open";

      Method_Address   : System.Address;
      Method_Size      : Interfaces.Unsigned_32;
      URL_Address      : System.Address;
      URL_Size         : Interfaces.Unsigned_32;
      Username_Address : System.Address;
      Username_Size    : Interfaces.Unsigned_32;
      Password_Address : System.Address;
      Password_Size    : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Method, Method_Address, Method_Size);
      Web.Strings.WASM_Helpers.To_JS (URL, URL_Address, URL_Size);
      Web.Strings.WASM_Helpers.To_JS
       (Username, Username_Address, Username_Size);
      Web.Strings.WASM_Helpers.To_JS
       (Password, Password_Address, Password_Size);

      Imported
       (Self.Identifier,
        Method_Address,
        Method_Size,
        URL_Address,
        URL_Size,
        (if Async then 1 else 0),
        Username_Address,
        Username_Size,
        Password_Address,
        Password_Size);
   end Open;

   ----------
   -- Send --
   ----------

   procedure Send
     (Self : XML_Http_Request'Class;
      Data : Ada.Streams.Stream_Element_Array)
   is
      procedure Imported
       (Identifier   : WASM.Objects.Object_Identifier;
        Data_Address : System.Address;
        Data_Size    : Interfaces.Unsigned_32)
          with Import => True,
               Convention => C,
               Link_Name => "__adawebpack__xhr__XMLHttpRequest__send";

   begin
      Imported (Self.Identifier, Data'Address, Data'Length);
   end Send;

   ----------
   -- Send --
   ----------

   procedure Send
    (Self : XML_Http_Request'Class;
     Data : Web.Strings.Web_String) is
   begin
      WASM.Objects.Methods.Call_Void_String (Self, WASM.Methods.Send, Data);
   end Send;

   ------------------------
   -- Set_Request_Header --
   ------------------------

   procedure Set_Request_Header
    (Self   : XML_Http_Request'Class;
     Header : Web.Strings.Web_String;
     Value  : Web.Strings.Web_String)
   is
      procedure Imported
       (Identifier     : WASM.Objects.Object_Identifier;
        Header_Address : System.Address;
        Header_Size    : Interfaces.Unsigned_32;
        Value_Address  : System.Address;
        Value_Size     : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__xhr__XMLHttpRequest__setRequestHeader";

      Header_Address : System.Address;
      Header_Size    : Interfaces.Unsigned_32;
      Value_Address  : System.Address;
      Value_Size     : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Header, Header_Address, Header_Size);
      Web.Strings.WASM_Helpers.To_JS (Value, Value_Address, Value_Size);
      Imported
       (Self.Identifier,
        Header_Address,
        Header_Size,
        Value_Address,
        Value_Size);
   end Set_Request_Header;

   -----------------------
   -- Set_Response_Type --
   -----------------------

   procedure Set_Response_Type
    (Self : in out XML_Http_Request'Class;
     To   : Response_Type_Kind)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Size       : Interfaces.Unsigned_32)
          with Import => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__xhr__XMLHttpRequest__responseType_setter";

      Value : constant Web.Strings.Web_String
        := (case To is
            when Default => +"",
            when Array_Buffer => +"arraybuffer",
            when Blob => +"blob",
            when Document => +"document",
            when JSON => +"json",
            when Text => +"text");
      A     : System.Address;
      S     : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Value, A, S);
      Imported (Self.Identifier, A, S);
   end Set_Response_Type;

end Web.XHR.Requests;
