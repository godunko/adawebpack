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

package body WASM.Objects.Attributes is

   -----------------
   -- Get_Boolean --
   -----------------

   function Get_Boolean
     (Self : Object_Reference'Class;
      Name : WASM.Attributes.Attribute_Index) return Boolean
   is

      use type Interfaces.Unsigned_32;

      function Imported
       (Object    : WASM.Objects.Object_Identifier;
        Attribute : WASM.Attributes.Attribute_Index)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack___boolean_getter";

   begin
      return Imported (Self.Identifier, Name) /= 0;
   end Get_Boolean;

   -----------------
   -- Set_Boolean --
   -----------------

   procedure Set_Boolean
     (Self : Object_Reference'Class;
      Name : WASM.Attributes.Attribute_Index;
      To   : Boolean)
   is
      procedure Imported
       (Object    : WASM.Objects.Object_Identifier;
        Attribute : WASM.Attributes.Attribute_Index;
        To        : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack___boolean_setter";

   begin
      Imported (Self.Identifier, Name, Boolean'Pos (To));
   end Set_Boolean;

   ----------------
   -- Get_Object --
   ----------------

   function Get_Object
     (Self : Object_Reference'Class;
      Name : WASM.Attributes.Attribute_Index)
      return WASM.Objects.Object_Identifier
   is
      function Imported
       (Object    : WASM.Objects.Object_Identifier;
        Attribute : WASM.Attributes.Attribute_Index)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack___object_getter";
   begin
      return Imported (Self.Identifier, Name);
   end Get_Object;

end WASM.Objects.Attributes;
