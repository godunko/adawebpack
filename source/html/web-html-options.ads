------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2021-2022, Vadim Godunko                                    --
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

with Web.HTML.Elements;
with Web.Strings;

package Web.HTML.Options is

   pragma Preelaborate;

   type HTML_Option_Element is
     new Web.HTML.Elements.HTML_Element with null record;

--  [NamedConstructor=Option(optional DOMString text = "",
--     optional DOMString value, optional boolean defaultSelected = false,
--     optional boolean selected = false)]
--  interface HTMLOptionElement : HTMLElement {
--    readonly attribute HTMLFormElement? form;
--    attribute DOMString label;
--    attribute boolean defaultSelected;
--    attribute DOMString value;
--
--    attribute DOMString text;
--    readonly attribute long index;
--  };

   function Get_Disabled (Self : HTML_Option_Element'Class) return Boolean;

   procedure Set_Disabled
     (Self : HTML_Option_Element'Class; To : Boolean);

   function Get_Selected (Self : HTML_Option_Element'Class) return Boolean;
   procedure Set_Selected
    (Self : in out HTML_Option_Element'Class; To : Boolean);
   --  Returns true if the element is selected, and false otherwise.
   --
   --  Can be set, to override the current state of the element.

   function Get_Value
     (Self : HTML_Option_Element'Class) return Web.Strings.Web_String;

   procedure Set_Value
     (Self : HTML_Option_Element'Class;
      To   : Web.Strings.Web_String);
   --  The value attribute provides a value for element. The value of an
   --  option element is the value of the value content attribute, if there
   --  is one, or, if there is not, the value of the element's text IDL
   --  attribute.

end Web.HTML.Options;
