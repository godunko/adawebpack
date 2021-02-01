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

with System;

with WASM.Attributes;
with WASM.Objects.Attributes;
with Web.Strings.WASM_Helpers;

package body Web.HTML.Selects is

   ------------------
   -- Get_Disabled --
   ------------------

   function Get_Disabled (Self : HTML_Select_Element'Class) return Boolean is
   begin
      return
        WASM.Objects.Attributes.Get_Boolean (Self, WASM.Attributes.Disabled);
   end Get_Disabled;

   ------------------------
   -- Get_Selected_Index --
   ------------------------

   function Get_Selected_Index
    (Self : HTML_Select_Element'Class) return Web.DOM_Long
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return Interfaces.Integer_32
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Select__selectedIndex_getter";
   begin
      return Imported (Self.Identifier);
   end Get_Selected_Index;

   ---------------
   -- Get_Value --
   ---------------

   function Get_Value
    (Self : HTML_Select_Element'Class) return Web.Strings.Web_String
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Select__value_getter";

   begin
      return Web.Strings.WASM_Helpers.To_Ada (Imported (Self.Identifier));
   end Get_Value;

   ------------------
   -- Set_Disabled --
   ------------------

   procedure Set_Disabled
    (Self : in out HTML_Select_Element;
     To   : Boolean) is
   begin
      WASM.Objects.Attributes.Set_Boolean (Self, WASM.Attributes.Disabled, To);
   end Set_Disabled;

   ------------------------
   -- Set_Selected_Index --
   ------------------------

   procedure Set_Selected_Index
    (Self : in out HTML_Select_Element'Class;
     To   : Web.DOM_Long)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        To         : Interfaces.Integer_32)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__html__Select__selectedIndex_setter";

   begin
      Imported (Self.Identifier, To);
   end Set_Selected_Index;

   ---------------
   -- Set_Value --
   ---------------

   procedure Set_Value
    (Self : in out HTML_Select_Element'Class;
     To   : Web.Strings.Web_String)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Size       : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__html__Select__value_setter";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (To, A, S);
      Imported (Self.Identifier, A, S);
   end Set_Value;

end Web.HTML.Selects;
