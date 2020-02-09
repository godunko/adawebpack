------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2016-2020, Vadim Godunko                                    --
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

package Web.HTML.Selects is

   pragma Preelaborate;

   type HTML_Select_Element is
     new Web.HTML.Elements.HTML_Element with null record;

--  interface HTMLSelectElement : HTMLElement {
--    attribute DOMString autocomplete;
--    attribute boolean autofocus;
--    readonly attribute HTMLFormElement? form;
--    attribute boolean multiple;
--    attribute DOMString name;
--    attribute boolean _required;
--    attribute unsigned long size;
--  
--    readonly attribute DOMString type;
--  
--    [SameObject] readonly attribute HTMLOptionsCollection options;
--    attribute unsigned long length;
--    getter Element? item(unsigned long index
--  );
--    HTMLOptionElement? namedItem(DOMString name
--  );
--    void add((HTMLOptionElement or HTMLOptGroupElement) element
--  , optional (HTMLElement or long)? before
--   = null);
--    void remove(); // ChildNode overload
--    void remove(long index
--  );
--    setter void (unsigned long index
--  , HTMLOptionElement? option
--  );
--  
--    [SameObject] readonly attribute HTMLCollection selectedOptions;
--    attribute long selectedIndex;
--  
--    readonly attribute boolean willValidate;
--    readonly attribute ValidityState validity;
--    readonly attribute DOMString validationMessage;
--    boolean checkValidity();
--    boolean reportValidity();
--    void setCustomValidity(DOMString error
--  );
--  
--    [SameObject] readonly attribute NodeList labels;
--  };


--   not overriding function Get_Autofocus
--    (Self : not null access constant HTML_Select_Element)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "autofocus";
--
--   not overriding procedure Set_Autofocus
--    (Self : not null access constant HTML_Select_Element;
--     To   : WebAPI.DOM_Boolean) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "autofocus";

   function Get_Disabled (Self : HTML_Select_Element'Class) return Boolean;

   procedure Set_Disabled
    (Self : in out HTML_Select_Element;
     To   : Boolean);

--   --    readonly attribute HTMLFormElement? form;
--
--   not overriding function Get_Multiple
--    (Self : not null access constant HTML_Select_Element)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "multiple";
--
--   not overriding procedure Set_Multiple
--    (Self : not null access constant HTML_Select_Element;
--     To   : WebAPI.DOM_Boolean) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "multiple";
--
--   not overriding function Get_Name
--    (Self : not null access constant HTML_Select_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "name";
--
--   not overriding procedure Set_Name
--    (Self : not null access constant HTML_Select_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "name";
--
--   not overriding function Get_Required
--    (Self : not null access constant HTML_Select_Element)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "required";
--
--   not overriding procedure Set_Required
--    (Self : not null access constant HTML_Select_Element;
--     To   : WebAPI.DOM_Boolean) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "required";
--
--   --             attribute unsigned long size;
--
--   not overriding function Get_Type
--    (Self : not null access constant HTML_Select_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "type";
--
--   --    readonly attribute HTMLOptionsCollection options;
--   --             attribute unsigned long length;
--   --    getter Element? item(unsigned long index);
--   --    HTMLOptionElement? namedItem(DOMString name);
--   --    void add((HTMLOptionElement or HTMLOptGroupElement) element, optional (HTMLElement or long)? before = null);
--   --    void remove(); // ChildNode overload
--   --    void remove(long index);
--   --    setter creator void (unsigned long index, HTMLOptionElement? option);
--   --  
--   --    readonly attribute HTMLCollection selectedOptions;
--
--   not overriding function Get_Selected_Index
--    (Self : not null access constant HTML_Select_Element)
--       return WebAPI.DOM_Long is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "selectedIndex";
--
--   not overriding procedure Set_Selected_Index
--    (Self : not null access constant HTML_Select_Element;
--     To   : WebAPI.DOM_Long) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "selectedIndex";

   function Get_Value
    (Self : HTML_Select_Element'Class) return Web.Strings.Web_String;

   procedure Set_Value
    (Self : in out HTML_Select_Element'Class;
     To   : Web.Strings.Web_String);

--   not overriding function Get_Will_Validate
--    (Self : not null access constant HTML_Select_Element)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "willValidate";
--
--   not overriding procedure Set_Will_Validate
--    (Self : not null access constant HTML_Select_Element;
--     To   : WebAPI.DOM_Boolean) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "willValidate";
--
--   --    readonly attribute ValidityState validity;
--
--   not overriding function Get_Validation_Message
--    (Self : not null access constant HTML_Select_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "validationMessage";
--
--   not overriding function Check_Validity
--    (Self : not null access constant HTML_Select_Element)
--       return Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "checkValidity";
--
--   not overriding procedure Set_Custom_Validity
--    (Self  : not null access constant HTML_Select_Element;
--     Error : WebAPI.DOM_String) is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "setCustomValidity";
--
--   --    readonly attribute NodeList labels;

end Web.HTML.Selects;
