------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2020-2021, Vadim Godunko                                    --
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

with Ada.Unchecked_Conversion;
with Interfaces;
with System;

with WASM.Attributes;
with WASM.Methods;
with WASM.Objects.Attributes;
with WASM.Objects.Methods;
with Web.DOM.Documents;
with Web.DOM.Elements;
with Web.DOM.Events;
with Web.HTML.Elements;
with Web.Strings.WASM_Helpers;
with Web.Utilities;

package body Web.DOM.Nodes is

   function "+" (Item : Wide_Wide_String) return Web.Strings.Web_String
     renames Web.Strings.To_Web_String;

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

   ------------------
   -- Append_Child --
   ------------------

   function Append_Child
    (Self : in out Node'Class;
     Node : Web.DOM.Nodes.Node'Class) return Web.DOM.Nodes.Node
   is
      function Imported
       (Identifier      : WASM.Objects.Object_Identifier;
        Node_Identifier : WASM.Objects.Object_Identifier)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__dom__Node__appendChild";

   begin
      return
        Web.DOM.Nodes.Instantiate
         (Imported (Self.Identifier, Node.Identifier));
   end Append_Child;

   ------------------
   -- Append_Child --
   ------------------

   procedure Append_Child
    (Self : in out Node'Class;
     Node : Web.DOM.Nodes.Node'Class)
   is
      Dummy : Web.DOM.Nodes.Node;

   begin
      Dummy := Self.Append_Child (Node);
   end Append_Child;

   ---------------------
   -- As_HTML_Element --
   ---------------------

   function As_HTML_Element
    (Self : Node'Class) return Web.HTML.Elements.HTML_Element is
   begin
      if not Self.Is_Null
        and then not Web.Utilities.Is_Instance_Of (Self, +"HTMLElement")
      then
         raise Constraint_Error;

      else
         return Web.HTML.Elements.Instantiate (Self.Identifier);
      end if;
   end As_HTML_Element;

   ----------------
   -- Clone_Node --
   ----------------

   function Clone_Node
     (Self : Node'Class; Deep : Boolean := False) return Web.DOM.Nodes.Node is
   begin
      return
        Web.DOM.Nodes.Instantiate
          (WASM.Objects.Methods.Call_Object_Boolean
             (Self, WASM.Methods.Clone_Node, Deep));
   end Clone_Node;

   --------------------
   -- Dispatch_Event --
   --------------------

   procedure Dispatch_Event
    (Callback   : System.Address;
     Identifier : WASM.Objects.Object_Identifier)
   is
      function To_Object is
        new Ada.Unchecked_Conversion
             (System.Address, Web.DOM.Event_Listeners.Event_Listener_Access);

      E : Web.DOM.Events.Event := Web.DOM.Events.Instantiate (Identifier);

   begin
      To_Object (Callback).Handle_Event (E);
   end Dispatch_Event;

   ---------------------
   -- Get_First_Child --
   ---------------------

   function Get_First_Child (Self : Node'Class) return Web.DOM.Nodes.Node is
   begin
      return
        Web.DOM.Nodes.Instantiate
         (WASM.Objects.Attributes.Get_Object
           (Self, WASM.Attributes.First_Child));
   end Get_First_Child;

   ----------------------
   -- Get_Next_Sibling --
   ----------------------

   function Get_Next_Sibling (Self : Node'Class) return Web.DOM.Nodes.Node is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__dom__Node__nextSibling_getter";

   begin
      return Web.DOM.Nodes.Instantiate (Imported (Self.Identifier));
   end Get_Next_Sibling;

   -------------------
   -- Get_Node_Type --
   -------------------

   function Get_Node_Type (Self : Node'Class) return Web.DOM.Nodes.Node_Types is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return Web.DOM_Unsigned_Short
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__dom__Node__nodeType_getter";

      function To_Node_Types is
        new Ada.Unchecked_Conversion
             (Web.DOM_Unsigned_Short, Web.DOM.Nodes.Node_Types);

   begin
      return To_Node_Types (Imported (Self.Identifier));
   end Get_Node_Type;

   ------------------------
   -- Get_Owner_Document --
   ------------------------

   function Get_Owner_Document
    (Self : Node'Class) return Web.DOM.Documents.Document
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__dom__Node__ownerDocument_getter";
   begin
      return Web.DOM.Documents.Instantiate (Imported (Self.Identifier));
   end Get_Owner_Document;

   ------------------------
   -- Get_Parent_Element --
   ------------------------

   function Get_Parent_Element
     (Self : Node'Class) return Web.DOM.Elements.Element is
   begin
      return
        Web.DOM.Elements.Instantiate
         (WASM.Objects.Attributes.Get_Object
           (Self, WASM.Attributes.Parent_Element));
   end Get_Parent_Element;

   ------------------
   -- Remove_Child --
   ------------------

   function Remove_Child
    (Self : in out Node'Class;
     Node : Web.DOM.Nodes.Node'Class) return Web.DOM.Nodes.Node
   is
      function Imported
       (Identifier      : WASM.Objects.Object_Identifier;
        Node_Identifier : WASM.Objects.Object_Identifier)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__dom__Node__removeChild";

   begin
      return
        Web.DOM.Nodes.Instantiate
         (Imported (Self.Identifier, Node.Identifier));
   end Remove_Child;

   ------------------
   -- Remove_Child --
   ------------------

   procedure Remove_Child
    (Self : in out Node'Class;
     Node : Web.DOM.Nodes.Node'Class)
   is
      Dummy : Web.DOM.Nodes.Node;

   begin
      Dummy := Self.Remove_Child (Node);
   end Remove_Child;

end Web.DOM.Nodes;
