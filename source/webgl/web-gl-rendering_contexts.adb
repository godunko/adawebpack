------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2020, Vadim Godunko                                         --
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

package body Web.GL.Rendering_Contexts is

   -----------
   -- Clear --
   -----------

   procedure Clear
    (Self : in out WebGL_Rendering_Context'Class;
     Mask : GLbitfield)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Mask       : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__webgl__RenderingContext__clear";

   begin
      Imported (Self.Identifier, Interfaces.Unsigned_32 (Mask));
   end Clear;

   -----------------
   -- Clear_Color --
   -----------------

   procedure Clear_Color
    (Self  : in out WebGL_Rendering_Context'Class;
     Red   : GLclampf;
     Green : GLclampf;
     Blue  : GLclampf;
     Alpha : GLclampf)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Red        : Interfaces.IEEE_Float_32;
        Green      : Interfaces.IEEE_Float_32;
        Blue       : Interfaces.IEEE_Float_32;
        Alpha      : Interfaces.IEEE_Float_32)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__clearColor";
   begin
      Imported
       (Self.Identifier,
        Interfaces.IEEE_Float_32 (Red),
        Interfaces.IEEE_Float_32 (Green),
        Interfaces.IEEE_Float_32 (Blue),
        Interfaces.IEEE_Float_32 (Alpha));
   end Clear_Color;

   --------------------
   -- Compile_Shader --
   --------------------

   procedure Compile_Shader
    (Self   : in out WebGL_Rendering_Context'Class;
     Shader : in out Web.GL.Shaders.WebGL_Shader'Class)
   is
      procedure Imported
       (Context_Identifier : WASM.Objects.Object_Identifier;
        Shader_Identifier  : WASM.Objects.Object_Identifier)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__compileShader";

   begin
      Imported (Self.Identifier, Shader.Identifier);
   end Compile_Shader;

   -------------------
   -- Create_Shader --
   -------------------

   function Create_Shader
    (Self     : in out WebGL_Rendering_Context'Class;
     The_Type : GLenum) return Web.GL.Shaders.WebGL_Shader
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier;
        The_Type   : Interfaces.Unsigned_32)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__webgl__RenderingContext__createShader";

   begin
      return
        Web.GL.Shaders.Instantiate
         (Imported (Self.Identifier, Interfaces.Unsigned_32 (The_Type)));
   end Create_Shader;

   -------------------
   -- Shader_Source --
   -------------------

   procedure Shader_Source
    (Self   : in out WebGL_Rendering_Context;
     Shader : in out Web.GL.Shaders.WebGL_Shader'Class;
     Source : Web.Strings.Web_String)
   is
      procedure Imported
       (Context_Identifier : WASM.Objects.Object_Identifier;
        Shader_Identifier  : WASM.Objects.Object_Identifier;
        Source_Address     : System.Address;
        Source_Size        : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__shaderSource";

      Source_A : System.Address;
      Source_S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Source, Source_A, Source_S);
      Imported (Self.Identifier, Shader.Identifier, Source_A, Source_S);
   end Shader_Source;

end Web.GL.Rendering_Contexts;
