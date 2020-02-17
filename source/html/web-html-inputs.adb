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
-- Copyright © 2020, Vadim Godunko <vgodunko@gmail.com>                     --
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

with System;

with WASM.Objects;
with Web.Strings.WASM_Helpers;

package body Web.HTML.Inputs is

   -----------------
   -- Get_Checked --
   -----------------

   function Get_Checked (Self : HTML_Input_Element'Class) return Boolean is
      function Imported
       (Self : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Input__checked_getter";

   begin
      return Imported (Self.Identifier) /= 0;
   end Get_Checked;

   ------------------
   -- Get_Disabled --
   ------------------

   function Get_Disabled (Self : HTML_Input_Element'Class) return Boolean is
      function Imported
       (Self : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Input__disabled_getter";

   begin
      return Imported (Self.Identifier) /= 0;
   end Get_Disabled;

   -------------
   -- Get_Max --
   -------------

   function Get_Max
    (Self : HTML_Input_Element'Class) return Web.Strings.Web_String
   is
      function Imported
       (Self : WASM.Objects.Object_Identifier)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Input__max_getter";

   begin
      return Web.Strings.WASM_Helpers.To_Ada (Imported (Self.Identifier));
   end Get_Max;

   -------------
   -- Get_Min --
   -------------

   function Get_Min
    (Self : HTML_Input_Element'Class) return Web.Strings.Web_String
   is
      function Imported
       (Self : WASM.Objects.Object_Identifier)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Input__min_getter";

   begin
      return Web.Strings.WASM_Helpers.To_Ada (Imported (Self.Identifier));
   end Get_Min;

   ------------------
   -- Get_Validity --
   ------------------

   function Get_Validity
    (Self : HTML_Input_Element'Class)
       return Web.HTML.Validity_States.Validity_State
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Input__validity_getter";

   begin
      return Web.HTML.Validity_States.Instantiate (Imported (Self.Identifier));
   end Get_Validity;

   ---------------
   -- Get_Value --
   ---------------

   function Get_Value
    (Self : HTML_Input_Element'Class) return Web.Strings.Web_String
   is
      function Imported
       (Self : WASM.Objects.Object_Identifier)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Input__value_getter";

   begin
      return Web.Strings.WASM_Helpers.To_Ada (Imported (Self.Identifier));
   end Get_Value;

   -----------------
   -- Set_Checked --
   -----------------

   procedure Set_Checked
    (Self : in out HTML_Input_Element'Class;
     To   : Boolean)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        To         : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__html__Input__checked_setter";

   begin
      Imported (Self.Identifier, (if To then 1 else 0));
   end Set_Checked;

   ------------------
   -- Set_Disabled --
   ------------------

   procedure Set_Disabled
    (Self : in out HTML_Input_Element'Class;
     To   : Boolean)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        To         : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__html__Input__disabled_setter";

   begin
      Imported (Self.Identifier, (if To then 1 else 0));
   end Set_Disabled;

   -------------
   -- Set_Max --
   -------------

   procedure Set_Max
    (Self : in out HTML_Input_Element'Class;
     To   : Web.Strings.Web_String)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Size       : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__html__Input__max_setter";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (To, A, S);
      Imported (Self.Identifier, A, S);
   end Set_Max;

   -------------
   -- Set_Min --
   -------------

   procedure Set_Min
    (Self : in out HTML_Input_Element'Class;
     To   : Web.Strings.Web_String)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Size       : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__html__Input__min_setter";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (To, A, S);
      Imported (Self.Identifier, A, S);
   end Set_Min;

   ---------------
   -- Set_Value --
   ---------------

   procedure Set_Value
    (Self : in out HTML_Input_Element'Class;
     To   : Web.Strings.Web_String)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Size       : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__html__Input__value_setter";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (To, A, S);
      Imported (Self.Identifier, A, S);
   end Set_Value;

end Web.HTML.Inputs;
