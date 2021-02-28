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

with Web.DOM.Elements;
with Web.DOM.String_Maps;
limited with Web.HTML.Buttons;
limited with Web.HTML.Canvases;
limited with Web.HTML.Images;
limited with Web.HTML.Inputs;
limited with Web.HTML.Opt_Groups;
limited with Web.HTML.Options;
limited with Web.HTML.Scripts;
limited with Web.HTML.Selects;
limited with Web.HTML.Templates;

package Web.HTML.Elements is

   pragma Preelaborate;

   type HTML_Element is new Web.DOM.Elements.Element with null record;
--  interface HTMLElement : Element {
--    // metadata attributes
--    [CEReactions] attribute DOMString title;
--    [CEReactions] attribute DOMString lang;
--    [CEReactions] attribute boolean translate;
--    [CEReactions] attribute DOMString dir;
--
--    // user interaction
--    void click();
--    [CEReactions] attribute long tabIndex;
--    void focus();
--    void blur();
--    [CEReactions] attribute DOMString accessKey;
--    [CEReactions] attribute boolean draggable;
--    [CEReactions] attribute boolean spellcheck;
--    void forceSpellCheck();
--    [CEReactions, TreatNullAs=EmptyString] attribute DOMString innerText;
--  };
--  HTMLElement implements GlobalEventHandlers;
--  HTMLElement implements DocumentAndElementEventHandlers;
--  HTMLElement implements ElementContentEditable;

   function Get_Dataset
    (Self : HTML_Element'Class) return Web.DOM.String_Maps.DOM_String_Map;
   --  Returns a DOMStringMap object for the element's data-* attributes.
   --
   -- Hyphenated names are converted to dromedary-case (which is the same
   -- as camel-case except the initial letter is not uppercased). For
   -- example, data-foo-bar="" becomes element.dataset.fooBar.

   function Get_Hidden (Self : HTML_Element'Class) return Boolean;
   procedure Set_Hidden (Self : in out HTML_Element'Class; To : Boolean);

   -----------------
   --  Utilities  --
   -----------------

   function As_HTML_Button
    (Self : HTML_Element'Class) return Web.HTML.Buttons.HTML_Button_Element;

   function As_HTML_Canvas
    (Self : HTML_Element'Class) return Web.HTML.Canvases.HTML_Canvas_Element;

   function As_HTML_Image
    (Self : HTML_Element'Class) return Web.HTML.Images.HTML_Image_Element;

   function As_HTML_Input
    (Self : HTML_Element'Class) return Web.HTML.Inputs.HTML_Input_Element;

   function As_HTML_Opt_Group
    (Self : HTML_Element'Class)
       return Web.HTML.Opt_Groups.HTML_Opt_Group_Element;

   function As_HTML_Option
    (Self : HTML_Element'Class) return Web.HTML.Options.HTML_Option_Element;

   function As_HTML_Script
    (Self : HTML_Element'Class) return Web.HTML.Scripts.HTML_Script_Element;

   function As_HTML_Select
    (Self : HTML_Element'Class) return Web.HTML.Selects.HTML_Select_Element;

   function As_HTML_Template
    (Self : HTML_Element'Class) return Web.HTML.Templates.HTML_Template_Element;

end Web.HTML.Elements;
