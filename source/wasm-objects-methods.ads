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
--  Helper subprograms to do call of object's methods with given profile.
--  Helper subprograms accepts object and index of the method in the global
--  method names table defined at JavaScript side. This allows to share code
--  to do calls of the methods with same profile of any objects.

with Interfaces;

with WASM.Methods;
with Web.Strings;

package WASM.Objects.Methods is

   pragma Preelaborate;

   function Call_Object_Object
     (Self : Object_Reference'Class;
      Name : WASM.Methods.Method_Index)
      return WASM.Objects.Object_Identifier;

   function Call_Object_Boolean
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Boolean)
      return WASM.Objects.Object_Identifier;

   function Call_Object_String
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Web.Strings.Web_String)
      return WASM.Objects.Object_Identifier;

   function Call_String
     (Self : Object_Reference'Class;
      Name : WASM.Methods.Method_Index)
      return Web.Strings.Web_String;

   function Call_String_String
     (Self      : Object_Reference'Class;
      Name      : WASM.Methods.Method_Index;
      Parameter : Web.Strings.Web_String)
      return Web.Strings.Web_String;

   procedure Call_Void_String
     (Self      : Object_Reference'Class;
      Name      : WASM.Methods.Method_Index;
      Parameter : Web.Strings.Web_String);

   procedure Call_Void_String_String
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Web.Strings.Web_String;
      Parameter_2 : Web.Strings.Web_String);

   procedure Call_Void_Object
     (Self      : Object_Reference'Class;
      Name      : WASM.Methods.Method_Index;
      Parameter : Object_Reference'Class);

   procedure Call_Void_U32_Object
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Interfaces.Unsigned_32;
      Parameter_2 : Object_Reference'Class);

   procedure Call_Void_U32_U32_I32
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Interfaces.Unsigned_32;
      Parameter_2 : Interfaces.Unsigned_32;
      Parameter_3 : Interfaces.Integer_32);

   procedure Call_Void_U32_U32_I32_I32
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Interfaces.Unsigned_32;
      Parameter_2 : Interfaces.Unsigned_32;
      Parameter_3 : Interfaces.Integer_32;
      Parameter_4 : Interfaces.Integer_32);

   procedure Call_Void_U32_U32_U32_Object
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Interfaces.Unsigned_32;
      Parameter_2 : Interfaces.Unsigned_32;
      Parameter_3 : Interfaces.Unsigned_32;
      Parameter_4 : Object_Reference'Class);

   procedure Call_Void_U32_U32_U32_Object_I32
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Interfaces.Unsigned_32;
      Parameter_2 : Interfaces.Unsigned_32;
      Parameter_3 : Interfaces.Unsigned_32;
      Parameter_4 : Object_Reference'Class;
      Parameter_5 : Interfaces.Integer_32);

end WASM.Objects.Methods;
