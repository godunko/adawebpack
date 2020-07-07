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
-- Copyright © 2016-2020, Vadim Godunko <vgodunko@gmail.com>                --
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

with Ada.Streams;

--with WebAPI.DOM.Documents;
--  with Web.DOM.Events;
--  with Web.XHR.Event_Targets;
--with WebAPI.XHR.Form_Datas;

with WASM.Objects;
with Web.DOM.Event_Listeners;
with Web.DOM.Event_Targets;
with Web.Strings;

package Web.XHR.Requests is

   pragma Preelaborate;

   subtype State is Web.DOM_Unsigned_Short range 0 .. 4;

   UNSENT           : constant State := 0;
   --  The object has been constructed.
   OPENED           : constant State := 1;
   --  The open() method has been successfully invoked. During this state
   --  request headers can be set using setRequestHeader() and the request
   --  can be made using the send() method.
   HEADERS_RECEIVED : constant State := 2;
   --  All redirects (if any) have been followed and all HTTP headers of the
   --  final response have been received. Several response members of the
   --  object are now available.
   LOADING          : constant State := 3;
   --  The response entity body is being received.
   DONE             : constant State := 4;
   --  The data transfer has been completed or something went wrong during the
   --  transfer (e.g. infinite redirects).

   type Response_Type_Kind is
    (Default,
     Array_Buffer,
     Blob,
     Document,
     JSON,
     Text);
   
   type XML_Http_Request is new WASM.Objects.Object_Reference
     and Web.DOM.Event_Targets.Event_Target
--   and Web.XHR.Event_Targets.XML_Http_Request_Event_Target
       with null record;
--   type XML_Http_Request is limited new WebAPI.XHR.Event_Targets.Event_Target
--     with private;

--   --  The following is the event handler (and its corresponding event handler
--   --  event type) that must be supported as attribute solely by the
--   --  XMLHttpRequest object:
--   --
--   --  * "readystatechange"

   function Get_Ready_State (Self : XML_Http_Request'Class) return State;
   --  The XMLHttpRequest object can be in several states. The readyState
   --  attribute must return the current state, which must be one of the
   --  following values:

   procedure Open
    (Self     : XML_Http_Request'Class;
     Method   : Web.Strings.Web_String;
     URL      : Web.Strings.Web_String;
     Async    : Boolean := True;
     Username : Web.Strings.Web_String := Web.Strings.Empty_Web_String;
     Password : Web.Strings.Web_String := Web.Strings.Empty_Web_String);
   --  Sets the request method, request URL, and synchronous flag.

   procedure Set_Request_Header
    (Self   : XML_Http_Request'Class;
     Header : Web.Strings.Web_String;
     Value  : Web.Strings.Web_String);
   --  Appends an header to the list of author request headers, or if header is
   --  already in the list of author request headers, combines its value with
   --  value.

--   not overriding function Get_Timeout
--    (Self : not null access constant XML_Http_Request)
--       return Natural
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "timeout";
--
--   not overriding procedure Set_Timeout
--    (Self  : not null access XML_Http_Request;
--     Value : Natural)
--         with Import     => True,
--              Convention => JavaScript_Property_Setter,
--              Link_Name  => "timeout";
--   --  Can be set to a time in milliseconds. When set to a non-zero value will
--   --  cause fetching to terminate after the given time has passed. When the
--   --  time has passed, the request has not yet completed, and the synchronous
--   --  flag is unset, a timeout event will then be dispatched, or a
--   --  "TimeoutError" exception will be thrown otherwise (for the send()
--   --  method).
--
--   not overriding function Get_With_Credentials
--    (Self : not null access constant XML_Http_Request)
--       return Boolean
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "withCredentials";
--   --  True when user credentials are to be included in a cross-origin request.
--   --  False when they are to be excluded in a cross-origin request and when
--   --  cookies are to be ignored in its response. Initially false.
--
--   not overriding procedure Set_With_Credentials
--    (Self  : not null access XML_Http_Request;
--     Value : Boolean)
--         with Import     => True,
--              Convention => JavaScript_Property_Setter,
--              Link_Name  => "withCredentials";
--
--   not overriding function Get_Upload
--    (Self : not null access constant XML_Http_Request)
--       return access WebAPI.XHR.Event_Targets.Event_Target'Class
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "upload";
--   --  Returns the associated XMLHttpRequestUpload object. It can be used to
--   --  gather transmission information when data is transferred to a server.

   procedure Send
    (Self : XML_Http_Request'Class;
     Data : Ada.Streams.Stream_Element_Array);
--   not overriding procedure Send
--    (Self : not null access XML_Http_Request;
--     Data : League.Strings.Universal_String)
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "send";
--   not overriding procedure Send
--    (Self : not null access XML_Http_Request;
--     Data : access WebAPI.XHR.Form_Datas.Form_Data'Class := null)
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "send";
   --  Initiates the request. The optional argument provides the request entity
   --  body. The argument is ignored if request method is GET or HEAD.
 
--   not overriding procedure Abort_Request
--    (Self     : not null access XML_Http_Request)
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "abort";
--   --  Cancels any network activity.

   --  Response
 
   function Get_Status 
    (Self : XML_Http_Request'Class) return Web.DOM_Unsigned_Short;
   --  Returns the HTTP status code.

--   not overriding function Get_Status_Text
--    (Self : not null access constant XML_Http_Request)
--       return League.Strings.Universal_String
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "statusText";
--   --  Returns the HTTP status text.
--
--   not overriding function Get_Response_Header
--    (Self   : not null access constant XML_Http_Request;
--     Header : League.Strings.Universal_String)
--       return League.Strings.Universal_String
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "getResponseHeader";
--   --  Returns the header field value from the response of which the field name
--   --  matches header, unless the field name is Set-Cookie or Set-Cookie2.
--
--   not overriding function Get_All_Response_Headers
--    (Self   : not null access constant XML_Http_Request;
--     Header : League.Strings.Universal_String)
--       return League.Strings.Universal_String
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "getAllResponseHeaders";
--   --  Returns all headers from the response, with the exception of those whose
--   --  field name is Set-Cookie or Set-Cookie2.
--
--   not overriding procedure Override_Mime_Type
--    (Self : not null access constant XML_Http_Request;
--     MIME : WebAPI.DOM_String)
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "overrideMimeType";
--   --  Sets the Content-Type header for the response to mime.

   function Get_Response_Type
    (Self : XML_Http_Request'Class) return Response_Type_Kind;
   --  Returns the response type.

   procedure Set_Response_Type
    (Self : in out XML_Http_Request'Class;
     To   : Response_Type_Kind);
   --  Can be set to change the response type. Values are: the empty string
   --  (default), "arraybuffer", "blob", "document", "json", and "text".

   function Get_Response
    (Self : XML_Http_Request'Class) return Ada.Streams.Stream_Element_Array;
   --  Returns the response’s body.
   
--   not overriding function Get_Response_Text
--    (Self : not null access constant XML_Http_Request)
--       return WebAPI.DOM_String
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "responseText";
--   --  Returns the text response entity body.
--
--   not overriding function Get_Response_XML
--    (Self : not null access constant XML_Http_Request)
--       return WebAPI.DOM.Documents.Document_Access
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "responseXML";
--   --  Returns the document response entity body.
--

   package Constructors is
      
      function New_XML_Http_Request return XML_Http_Request;
      
   end Constructors;
   
--private
--
--   type XML_Http_Request is limited new WebAPI.XHR.Event_Targets.Event_Target
--     with null record
--         with Export     => True,
--              Convention => JavaScript,
--              Link_Name  => "XMLHttpRequest";
--
--   overriding function Dispatch_Event
--    (Self  : not null access XML_Http_Request;
--     Event : not null access WebAPI.DOM.Events.Event'Class)
--     return Boolean
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "dispatchEvent";

private
   
   overriding procedure Add_Event_Listener
    (Self     : in out XML_Http_Request;
     Name     : Web.Strings.Web_String;
     Callback : not null Web.DOM.Event_Listeners.Event_Listener_Access;
     Capture  : Boolean := False);

end Web.XHR.Requests;
