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
-- Copyright © 2014-2022, Vadim Godunko <vgodunko@gmail.com>                --
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
--  $Revision: 5732 $ $Date: 2017-01-28 14:52:41 +0300 (Sat, 28 Jan 2017) $
------------------------------------------------------------------------------

with Web.HTML.Elements;
with Web.HTML.Validity_States;
with Web.Strings;

package Web.HTML.Inputs is

   pragma Preelaborate;

   type HTML_Input_Element is
     new Web.HTML.Elements.HTML_Element with null record;

--   XXX Not implemented

--  interface HTMLInputElement : HTMLElement {
--    attribute DOMString accept;
--    attribute DOMString alt;
--    attribute DOMString autocapitalize;
--    attribute DOMString autocomplete;
--    attribute boolean autofocus;
--    attribute boolean defaultChecked;
--    attribute DOMString dirName;
--    readonly attribute HTMLFormElement? form;
--    readonly attribute FileList? files;
--    attribute DOMString formAction;
--    attribute DOMString formEnctype;
--    attribute DOMString formMethod;
--    attribute boolean formNoValidate;
--    attribute DOMString formTarget;
--    attribute unsigned long height;
--    attribute boolean indeterminate;
--    readonly attribute HTMLElement? list;
--    attribute long maxLength;
--    attribute long minLength;
--    attribute boolean multiple;
--    attribute DOMString pattern;
--    attribute DOMString placeholder;
--    attribute boolean readOnly;
--    attribute boolean _required;
--    attribute unsigned long size;
--    attribute DOMString src;
--    attribute DOMString step;
--    attribute DOMString type;
--    attribute DOMString defaultValue;
--    [TreatNullAs=EmptyString] attribute DOMString value;
--    attribute object? valueAsDate;
--    attribute unrestricted double valueAsNumber;
--    attribute unsigned long width;
--
--    void stepUp(optional long n
--   = 1);
--    void stepDown(optional long n
--   = 1);
--
--    readonly attribute boolean willValidate;
--    readonly attribute DOMString validationMessage;
--    boolean checkValidity();
--    boolean reportValidity();
--    void setCustomValidity(DOMString error
--  );
--
--    [SameObject] readonly attribute NodeList labels;
--
--    void select();
--    attribute unsigned long? selectionStart;
--    attribute unsigned long? selectionEnd;
--    attribute DOMString? selectionDirection;
--    void setRangeText(DOMString replacement
--  );
--    void setRangeText(DOMString replacement
--  , unsigned long start
--  , unsigned long end
--  , optional SelectionMode selectionMode
--   = "preserve");
--    void setSelectionRange(unsigned long start
--  , unsigned long end
--  , optional DOMString direction
--  );
--  };

--   not overriding function Get_Accept
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "accept";
--
--   not overriding procedure Set_Accept
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "accept";
--
--   not overriding function Get_Alt
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "alt";
--
--   not overriding procedure Set_Alt
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "alt";
--
--   not overriding function Get_Autocomplete
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "autocomplete";
--
--   not overriding procedure Set_Autocomplete
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "autocomplete";
--
--   not overriding function Get_Autofocus
--    (Self : not null access constant HTML_Input_Element)
--       return Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "autofocus";
--
--   not overriding procedure Set_Autofocus
--    (Self : not null access constant HTML_Input_Element;
--     To   : Boolean) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "autofocus";
--
--   not overriding function Get_Default_Checked
--    (Self : not null access constant HTML_Input_Element)
--       return Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "defaultChecked";
--
--   not overriding procedure Set_Default_Checked
--    (Self : not null access constant HTML_Input_Element;
--     To   : Boolean) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "defaultChecked";

   function Get_Checked
    (Self : HTML_Input_Element'Class) return Boolean;

   procedure Set_Checked
    (Self : in out HTML_Input_Element'Class;
     To   : Boolean);

--   not overriding function Get_Dir_Name
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "dirName";
--
--   not overriding procedure Set_Dir_Name
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "dirName";

   function Get_Disabled (Self : HTML_Input_Element'Class) return Boolean;

   procedure Set_Disabled
    (Self : in out HTML_Input_Element'Class;
     To   : Boolean);

--   not overriding function Get_Form_Action
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "formAction";
--
--   not overriding procedure Set_Form_Action
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "formAction";
--
--   not overriding function Get_Form_Enctype
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "formEnctype";
--
--   not overriding procedure Set_Form_Enctype
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "formEnctype";
--
--   not overriding function Get_Form_Method
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "formMethod";
--
--   not overriding procedure Set_Form_Method
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "formMethod";
--
--   not overriding function Get_Form_No_Validate
--    (Self : not null access constant HTML_Input_Element)
--       return Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "formNoValidate";
--
--   not overriding procedure Set_Form_No_Validate
--    (Self : not null access constant HTML_Input_Element;
--     To   : Boolean) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "formNoValidate";
--
--   not overriding function Get_Form_Target
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "formTarget";
--
--   not overriding procedure Set_Form_Target
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "formTarget";
--
--   --             attribute unsigned long height;
--
--   not overriding function Get_Indeterminate
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "indeterminate";
--
--   not overriding procedure Set_Indeterminate
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_Boolean) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "indeterminate";
--
--   not overriding function Get_List
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.HTML.Elements.HTML_Element_Access is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "list";

   function Get_Max
    (Self : HTML_Input_Element'Class) return Web.Strings.Web_String;

   procedure Set_Max
    (Self : in out HTML_Input_Element'Class;
     To   : Web.Strings.Web_String);

--             attribute long maxLength;

   function Get_Min
    (Self : HTML_Input_Element'Class) return Web.Strings.Web_String;

   procedure Set_Min
    (Self : in out HTML_Input_Element'Class;
     To   : Web.Strings.Web_String);

--   --             attribute long minLength;
--
--   not overriding function Get_Multiple
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "multiple";
--
--   not overriding procedure Set_Multiple
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_Boolean) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "multiple";

   function Get_Name
    (Self : HTML_Input_Element'Class) return Web.Strings.Web_String;

   procedure Set_Name
    (Self : in out HTML_Input_Element'Class;
     To   : Web.Strings.Web_String);

--   not overriding function Get_Pattern
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "pattern";
--
--   not overriding procedure Set_Pattern
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "pattern";
--
--   not overriding function Get_Placeholder
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "placeholder";
--
--   not overriding procedure Set_Placeholder
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "placeholder";
--
--   not overriding function Get_Read_Only
--    (Self : not null access constant HTML_Input_Element)
--       return Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "readOnly";
--
--   not overriding procedure Set_Read_Only
--    (Self : not null access constant HTML_Input_Element;
--     To   : Boolean) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "readOnly";

   function Get_Required (Self : HTML_Input_Element'Class) return Boolean;

   procedure Set_Required
     (Self : in out HTML_Input_Element'Class;
      To   : Boolean);

--   --             attribute unsigned long size;
--
--   not overriding function Get_Src
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "src";
--
--   not overriding procedure Set_Src
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "src";

   function Get_Step
     (Self : HTML_Input_Element'Class) return Web.Strings.Web_String;

   procedure Set_Step
     (Self : in out HTML_Input_Element;
      To   : Web.Strings.Web_String);

--   not overriding function Get_Type
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "type";
--
--   not overriding procedure Set_Type
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "type";
--
--   not overriding function Get_Default_Value
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "defaultValue";
--
--   not overriding procedure Set_Default_Value
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "defaultValue";

   function Get_Value
    (Self : HTML_Input_Element'Class) return Web.Strings.Web_String;

   procedure Set_Value
    (Self : in out HTML_Input_Element'Class;
     To   : Web.Strings.Web_String);

--   --             attribute Date? valueAsDate;
--   --             attribute unrestricted double valueAsNumber;
--   --             attribute unsigned long width;
--   --
--   --    void stepUp(optional long n = 1);
--   --    void stepDown(optional long n = 1);
--
--   not overriding function Get_Will_Validate
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "willValidate";

   function Get_Validity
    (Self : HTML_Input_Element'Class)
       return Web.HTML.Validity_States.Validity_State;

--   not overriding function Get_Validation_Message
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "validationMessage";
--
--   not overriding function Check_Validity
--    (Self : not null access constant HTML_Input_Element)
--       return Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "checkValidity";
--
--   not overriding procedure Set_Custom_Validity
--    (Self  : not null access constant HTML_Input_Element;
--     Error : WebAPI.DOM_String) is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "setCustomValidity";
--
--   --    readonly attribute NodeList labels;
--   --
--   --    void select();
--   --             attribute unsigned long selectionStart;
--   --             attribute unsigned long selectionEnd;
--
--   not overriding function Get_Selection_Direction
--    (Self : not null access constant HTML_Input_Element)
--       return WebAPI.DOM_String is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "selectionDirection";
--
--   not overriding procedure Set_Selection_Direction
--    (Self : not null access constant HTML_Input_Element;
--     To   : WebAPI.DOM_String) is abstract
--       with Import     => True,
--            Convention => JavaScript_Property_Setter,
--            Link_Name  => "selectionDirection";
--
--   --    void setRangeText(DOMString replacement);
--   --    void setRangeText(DOMString replacement, unsigned long start, unsigned long end, optional SelectionMode selectionMode = "preserve");
--   --    void setSelectionRange(unsigned long start, unsigned long end, optional DOMString direction);

end Web.HTML.Inputs;
