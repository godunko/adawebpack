------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2021, Vadim Godunko                                         --
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
--  Helper subprograms to get and set values of the object's attributes of
--  different predefined types. Helper subprograms accepts object and index
--  of the attribute in the global attribute names table defined at JavaScript
--  side. This allows to share code to access to all attributes of the same
--  type of any objects.

with WASM.Attributes;
with Web.Strings;

package WASM.Objects.Attributes is

   pragma Preelaborate;

   function Get_Boolean
     (Self : Object_Reference'Class;
      Name : WASM.Attributes.Attribute_Index) return Boolean;

   procedure Set_Boolean
     (Self : Object_Reference'Class;
      Name : WASM.Attributes.Attribute_Index;
      To   : Boolean);

   function Get_String
     (Self : Object_Reference'Class;
      Name : WASM.Attributes.Attribute_Index)
      return Web.Strings.Web_String;

   procedure Set_String
     (Self : Object_Reference'Class;
      Name : WASM.Attributes.Attribute_Index;
      To   : Web.Strings.Web_String);

   function Get_Object
     (Self : Object_Reference'Class;
      Name : WASM.Attributes.Attribute_Index)
      return WASM.Objects.Object_Identifier;

end WASM.Objects.Attributes;
