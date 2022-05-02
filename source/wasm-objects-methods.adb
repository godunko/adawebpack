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

with System;

with Web.Strings.WASM_Helpers;

package body WASM.Objects.Methods is

   ------------------------
   -- Call_Object_Object --
   ------------------------

   function Call_Object_Object
     (Self : Object_Reference'Class;
      Name : WASM.Methods.Method_Index)
      return WASM.Objects.Object_Identifier
   is
      function Imported
       (Object : WASM.Objects.Object_Identifier;
        Method : WASM.Methods.Method_Index)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack___object_invoker";

   begin
      return Imported (Self.Identifier, Name);
   end Call_Object_Object;

   -------------------------
   -- Call_Object_Boolean --
   -------------------------

   function Call_Object_Boolean
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Boolean)
      return WASM.Objects.Object_Identifier
   is
      function Imported
       (Object      : WASM.Objects.Object_Identifier;
        Method      : WASM.Methods.Method_Index;
        Parameter_1 : Interfaces.Unsigned_32)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack___object_boolean_invoker";

   begin
      return Imported (Self.Identifier, Name, Boolean'Pos (Parameter_1));
   end Call_Object_Boolean;

   ------------------------
   -- Call_Object_String --
   ------------------------

   function Call_Object_String
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Web.Strings.Web_String)
      return WASM.Objects.Object_Identifier
   is
      function Imported
       (Object              : WASM.Objects.Object_Identifier;
        Method              : WASM.Methods.Method_Index;
        Parameter_1_Address : System.Address;
        Parameter_1_Size    : Interfaces.Unsigned_32)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack___object_string_invoker";

      Parameter_1_Address : System.Address;
      Parameter_1_Size    : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS
       (Parameter_1, Parameter_1_Address, Parameter_1_Size);

      return Imported (Self.Identifier, Name, Parameter_1_Address, Parameter_1_Size);
   end Call_Object_String;

   -----------------
   -- Call_String --
   -----------------

   function Call_String
     (Self : Object_Reference'Class;
      Name : WASM.Methods.Method_Index)
      return Web.Strings.Web_String
   is
      function Imported
       (Object    : WASM.Objects.Object_Identifier;
        Attribute : WASM.Methods.Method_Index)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack___string_invoker";

   begin
      return
        Web.Strings.WASM_Helpers.To_Ada (Imported (Self.Identifier, Name));
   end Call_String;

   ------------------------
   -- Call_String_String --
   ------------------------

   function Call_String_String
     (Self      : Object_Reference'Class;
      Name      : WASM.Methods.Method_Index;
      Parameter : Web.Strings.Web_String)
      return Web.Strings.Web_String
   is
      function Imported
       (Object    : WASM.Objects.Object_Identifier;
        Attribute : WASM.Methods.Method_Index;
        Address   : System.Address;
        Size      : Interfaces.Unsigned_32)
          return System.Address
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack___string_string_invoker";

      Address : System.Address;
      Size    : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Parameter, Address, Size);

      return
        Web.Strings.WASM_Helpers.To_Ada
          (Imported (Self.Identifier, Name, Address, Size));
   end Call_String_String;

   -----------------------------
   -- Call_Void_String_String --
   -----------------------------

   procedure Call_Void_String_String
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Web.Strings.Web_String;
      Parameter_2 : Web.Strings.Web_String)
   is
      procedure Imported
       (Object      : WASM.Objects.Object_Identifier;
        Method      : WASM.Methods.Method_Index;
        Parameter_1_Address : System.Address;
        Parameter_1_Size    : Interfaces.Unsigned_32;
        Parameter_2_Address : System.Address;
        Parameter_2_Size    : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack___void_string_string_invoker";

      Address_1 : System.Address;
      Size_1    : Interfaces.Unsigned_32;
      Address_2 : System.Address;
      Size_2    : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Parameter_1, Address_1, Size_1);
      Web.Strings.WASM_Helpers.To_JS (Parameter_2, Address_2, Size_2);

      Imported (Self.Identifier, Name, Address_1, Size_1, Address_2, Size_2);
   end Call_Void_String_String;

   ----------------------
   -- Call_Void_Object --
   ----------------------

   procedure Call_Void_Object
     (Self      : Object_Reference'Class;
      Name      : WASM.Methods.Method_Index;
      Parameter : Object_Reference'Class)
   is
      procedure Imported
       (Object    : WASM.Objects.Object_Identifier;
        Method    : WASM.Methods.Method_Index;
        Parameter : WASM.Objects.Object_Identifier)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack___void_object_invoker";

   begin
      Imported (Self.Identifier, Name, Parameter.Identifier);
   end Call_Void_Object;

   --------------------------
   -- Call_Void_U32_Object --
   --------------------------

   procedure Call_Void_U32_Object
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Interfaces.Unsigned_32;
      Parameter_2 : Object_Reference'Class)
   is
      procedure Imported
       (Object      : WASM.Objects.Object_Identifier;
        Method      : WASM.Methods.Method_Index;
        Parameter_1 : Interfaces.Unsigned_32;
        Parameter_2 : WASM.Objects.Object_Identifier)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack___void_i32_object_invoker";

   begin
      Imported (Self.Identifier, Name, Parameter_1, Parameter_2.Identifier);
   end Call_Void_U32_Object;

   ---------------------------
   -- Call_Void_U32_U32_I32 --
   ---------------------------

   procedure Call_Void_U32_U32_I32
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Interfaces.Unsigned_32;
      Parameter_2 : Interfaces.Unsigned_32;
      Parameter_3 : Interfaces.Integer_32)
   is
      procedure Imported
       (Object      : WASM.Objects.Object_Identifier;
        Method      : WASM.Methods.Method_Index;
        Parameter_1 : Interfaces.Unsigned_32;
        Parameter_2 : Interfaces.Unsigned_32;
        Parameter_3 : Interfaces.Integer_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack___void_i32_i32_i32_invoker";

   begin
      Imported (Self.Identifier, Name, Parameter_1, Parameter_2, Parameter_3);
   end Call_Void_U32_U32_I32;

   -------------------------------
   -- Call_Void_U32_U32_I32_I32 --
   -------------------------------

   procedure Call_Void_U32_U32_I32_I32
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Interfaces.Unsigned_32;
      Parameter_2 : Interfaces.Unsigned_32;
      Parameter_3 : Interfaces.Integer_32;
      Parameter_4 : Interfaces.Integer_32)
   is
      procedure Imported
       (Object      : WASM.Objects.Object_Identifier;
        Method      : WASM.Methods.Method_Index;
        Parameter_1 : Interfaces.Unsigned_32;
        Parameter_2 : Interfaces.Unsigned_32;
        Parameter_3 : Interfaces.Integer_32;
        Parameter_4 : Interfaces.Integer_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack___void_i32_i32_i32_i32_invoker";

   begin
      Imported
        (Self.Identifier,
         Name,
         Parameter_1,
         Parameter_2,
         Parameter_3,
         Parameter_4);
   end Call_Void_U32_U32_I32_I32;

   ----------------------------------
   -- Call_Void_U32_U32_U32_Object --
   ----------------------------------

   procedure Call_Void_U32_U32_U32_Object
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Interfaces.Unsigned_32;
      Parameter_2 : Interfaces.Unsigned_32;
      Parameter_3 : Interfaces.Unsigned_32;
      Parameter_4 : Object_Reference'Class)
   is
      procedure Imported
       (Object      : WASM.Objects.Object_Identifier;
        Method      : WASM.Methods.Method_Index;
        Parameter_1 : Interfaces.Unsigned_32;
        Parameter_2 : Interfaces.Unsigned_32;
        Parameter_3 : Interfaces.Unsigned_32;
        Parameter_4 : WASM.Objects.Object_Identifier)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack___void_i32_i32_i32_object_invoker";

   begin
      Imported
        (Self.Identifier,
         Name,
         Parameter_1,
         Parameter_2,
         Parameter_3,
         Parameter_4.Identifier);
   end Call_Void_U32_U32_U32_Object;

   --------------------------------------
   -- Call_Void_U32_U32_U32_Object_I32 --
   --------------------------------------

   procedure Call_Void_U32_U32_U32_Object_I32
     (Self        : Object_Reference'Class;
      Name        : WASM.Methods.Method_Index;
      Parameter_1 : Interfaces.Unsigned_32;
      Parameter_2 : Interfaces.Unsigned_32;
      Parameter_3 : Interfaces.Unsigned_32;
      Parameter_4 : Object_Reference'Class;
      Parameter_5 : Interfaces.Integer_32)
   is
      procedure Imported
       (Object      : WASM.Objects.Object_Identifier;
        Method      : WASM.Methods.Method_Index;
        Parameter_1 : Interfaces.Unsigned_32;
        Parameter_2 : Interfaces.Unsigned_32;
        Parameter_3 : Interfaces.Unsigned_32;
        Parameter_4 : WASM.Objects.Object_Identifier;
        Parameter_5 : Interfaces.Integer_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack___void_i32_i32_i32_object_i32_invoker";

   begin
      Imported
        (Self.Identifier,
         Name,
         Parameter_1,
         Parameter_2,
         Parameter_3,
         Parameter_4.Identifier,
         Parameter_5);
   end Call_Void_U32_U32_U32_Object_I32;

end WASM.Objects.Methods;
