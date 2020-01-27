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

with Web.Strings.WASM_Helpers;

package body Web.GL.Rendering_Contexts is

   -------------------
   -- Attach_Shader --
   -------------------

   procedure Attach_Shader
    (Self    : in out WebGL_Rendering_Context'Class;
     Program : in out Web.GL.Programs.WebGL_Program'Class;
     Shader  : in out Web.GL.Shaders.WebGL_Shader'Class)
   is
      procedure Imported
       (Context_Identifier : WASM.Objects.Object_Identifier;
        Program_Identifier : WASM.Objects.Object_Identifier;
        Shader_Identifier  : WASM.Objects.Object_Identifier)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__attachShader";

   begin
      Imported (Self.Identifier, Program.Identifier, Shader.Identifier);
   end Attach_Shader;

   -----------------
   -- Bind_Buffer --
   -----------------

   procedure Bind_Buffer
    (Self   : in out WebGL_Rendering_Context'Class;
     Target : GLenum;
     Buffer : Web.GL.Buffers.WebGL_Buffer'Class)
   is
      procedure Imported
       (Context_Identifier : WASM.Objects.Object_Identifier;
        Target             : Interfaces.Unsigned_32;
        Buffer_Identifier  : WASM.Objects.Object_Identifier)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__bindBuffer";

   begin
      Imported
       (Self.Identifier, Interfaces.Unsigned_32 (Target), Buffer.Identifier);
   end Bind_Buffer;

   -----------------
   -- Buffer_Data --
   -----------------

   procedure Buffer_Data
    (Self   : in out WebGL_Rendering_Context'Class;
     Target : Web.GL.GLenum;
     Size   : Web.GL.GLsizeiptr;
     Data   : System.Address;
     Usage  : Web.GL.GLenum)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Target     : Web.GL.GLenum;
        Size       : Web.GL.GLsizeiptr;
        Data       : System.Address;
        Usage      : Web.GL.GLenum)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__webgl__RenderingContext__bufferData";

   begin
      Imported (Self.Identifier, Target, Size, Data, Usage);
   end Buffer_Data;

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
        Red        : GLclampf;
        Green      : GLclampf;
        Blue       : GLclampf;
        Alpha      : GLclampf)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__clearColor";
   begin
      Imported (Self.Identifier, Red, Green, Blue, Alpha);
   end Clear_Color;

   -----------------
   -- Clear_Depth --
   -----------------

   procedure Clear_Depth
    (Self  : in out WebGL_Rendering_Context'Class;
     Depth : GLclampf)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Depth      : GLclampf)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__clearDepth";
   begin
      Imported (Self.Identifier, Depth);
   end Clear_Depth;

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
   -- Create_Buffer --
   -------------------

   function Create_Buffer
    (Self : in out WebGL_Rendering_Context'Class)
       return Web.GL.Buffers.WebGL_Buffer
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__webgl__RenderingContext__createBuffer";

   begin
      return Web.GL.Buffers.Instantiate (Imported (Self.Identifier));
   end Create_Buffer;

   --------------------
   -- Create_Program --
   --------------------

   function Create_Program
    (Self : in out WebGL_Rendering_Context'Class)
       return Web.GL.Programs.WebGL_Program
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__webgl__RenderingContext__createProgram";

   begin
      return Web.GL.Programs.Instantiate (Imported (Self.Identifier));
   end Create_Program;

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

   -----------------
   -- Draw_Arrays --
   -----------------

   procedure Draw_Arrays
    (Self  : WebGL_Rendering_Context'Class;
     Mode  : GLenum;
     First : GLint;
     Count : GLsizei)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Mode       : GLenum;
        First      : GLint;
        Count      : GLsizei)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__drawArrays";

   begin
      Imported (Self.Identifier, Mode, First, Count);
   end Draw_Arrays;

   -------------------
   -- Draw_Elements --
   -------------------

   procedure Draw_Elements
    (Self      : WebGL_Rendering_Context'Class;
     Mode      : GLenum;
     Count     : GLsizei;
     Data_Type : GLenum;
     Offset    : GLintptr)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Mode       : GLenum;
        Count      : GLsizei;
        Data_Type  : GLenum;
        Offset     : GLintptr)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__drawElements";

   begin
      Imported (Self.Identifier, Mode, Count, Data_Type, Offset);
   end Draw_Elements;

   --------------------------------
   -- Enable_Vertex_Attrib_Array --
   --------------------------------

   procedure Enable_Vertex_Attrib_Array
    (Self  : in out WebGL_Rendering_Context;
     Index : GLuint)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Index      : GLuint)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__enableVertexAttribArray";

   begin
      Imported (Self.Identifier, Index);
   end Enable_Vertex_Attrib_Array;

   ------------
   -- Finish --
   ------------

   procedure Finish (Self : in out WebGL_Rendering_Context) is
      procedure Imported (Identifier : WASM.Objects.Object_Identifier)
        with Import     => True,
             Convention => C,
             Link_Name  => "__adawebpack__webgl__RenderingContext__finish";

   begin
      Imported (Self.Identifier);
   end Finish;

   -----------
   -- Flush --
   -----------

   procedure Flush (Self : in out WebGL_Rendering_Context) is
      procedure Imported (Identifier : WASM.Objects.Object_Identifier)
        with Import     => True,
             Convention => C,
             Link_Name  => "__adawebpack__webgl__RenderingContext__flush";

   begin
      Imported (Self.Identifier);
   end Flush;

   -------------------------
   -- Get_Attrib_Location --
   -------------------------

   function Get_Attrib_Location
    (Self    : WebGL_Rendering_Context'Class;
     Program : Web.GL.Programs.WebGL_Program'Class;
     Name    : Web.Strings.Web_String) return GLint
   is
      function Imported
       (Context_Identifier : WASM.Objects.Object_Identifier;
        Program_Identifier : WASM.Objects.Object_Identifier;
        Name_Address       : System.Address;
        Name_Size          : Interfaces.Unsigned_32)
          return Interfaces.Integer_32
         with Import     => True,
              Convention => C,
              Link_Name  =>
                "__adawebpack__webgl__RenderingContext__getAttribLocation";

      Name_A : System.Address;
      Name_S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Name, Name_A, Name_S);

      return
        GLint (Imported (Self.Identifier, Program.Identifier, Name_A, Name_S));
   end Get_Attrib_Location;

   --------------------------
   -- Get_Uniform_Location --
   --------------------------

   function Get_Uniform_Location
    (Self    : WebGL_Rendering_Context'Class;
     Program : Web.GL.Programs.WebGL_Program'Class;
     Name    : Web.Strings.Web_String)
       return Web.GL.Uniform_Locations.WebGL_Uniform_Location
   is
      function Imported
       (Context_Identifier : WASM.Objects.Object_Identifier;
        Program_Identifier : WASM.Objects.Object_Identifier;
        Name_Address       : System.Address;
        Name_Size          : Interfaces.Unsigned_32)
          return WASM.Objects.Object_Identifier
              with Import     => True,
                   Convention => C,
                   Link_Name  =>
                     "__adawebpack__webgl__RenderingContext__getUniformLocation";

      Name_A : System.Address;
      Name_S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Name, Name_A, Name_S);

      return
        Web.GL.Uniform_Locations.Instantiate
         (Imported (Self.Identifier, Program.Identifier, Name_A, Name_S));
   end Get_Uniform_Location;

   ------------------
   -- Link_Program --
   ------------------

   procedure Link_Program
    (Self    : in out WebGL_Rendering_Context'Class;
     Program : in out Web.GL.Programs.WebGL_Program'Class)
   is
      procedure Imported
       (Context_Identifier : WASM.Objects.Object_Identifier;
        Program_Identifier : WASM.Objects.Object_Identifier)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__linkProgram";

   begin
      Imported (Self.Identifier, Program.Identifier);
   end Link_Program;

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

   ----------------
   -- Uniform_1f --
   ----------------

   procedure Uniform_1f
    (Self     : in out WebGL_Rendering_Context'Class;
     Location : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     X        : GLfloat)
   is
      procedure Imported
       (Context_Identifier  : WASM.Objects.Object_Identifier;
        Location_Identifier : WASM.Objects.Object_Identifier;
        Value               : GLfloat)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__uniform1f";

   begin
      Imported (Self.Identifier, Location.Identifier, X);
   end Uniform_1f;

   ----------------
   -- Uniform_1i --
   ----------------

   procedure Uniform_1i
    (Self     : in out WebGL_Rendering_Context'Class;
     Location : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     X        : GLint)
   is
      procedure Imported
       (Context_Identifier  : WASM.Objects.Object_Identifier;
        Location_Identifier : WASM.Objects.Object_Identifier;
        Value               : GLint)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__uniform1i";

   begin
      Imported (Self.Identifier, Location.Identifier, X);
   end Uniform_1i;

   -----------------
   -- Uniform_2fv --
   -----------------

   procedure Uniform_2fv
    (Self     : in out WebGL_Rendering_Context'Class;
     Location : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Value    : GLfloat_Vector_2)
   is
      procedure Imported
       (Context_Identifier  : WASM.Objects.Object_Identifier;
        Location_Identifier : WASM.Objects.Object_Identifier;
        Value_Address       : System.Address)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__uniform2fv";

   begin
      Imported
       (Self.Identifier, Location.Identifier, Value (Value'First)'Address);
   end Uniform_2fv;

   -----------------
   -- Uniform_3fv --
   -----------------

   procedure Uniform_3fv
    (Self     : in out WebGL_Rendering_Context'Class;
     Location : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Value    : GLfloat_Vector_3)
   is
      procedure Imported
       (Context_Identifier  : WASM.Objects.Object_Identifier;
        Location_Identifier : WASM.Objects.Object_Identifier;
        Value_Address       : System.Address)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__uniform3fv";

   begin
      Imported
       (Self.Identifier, Location.Identifier, Value (Value'First)'Address);
   end Uniform_3fv;

   -----------------
   -- Uniform_4fv --
   -----------------

   procedure Uniform_4fv
    (Self     : in out WebGL_Rendering_Context'Class;
     Location : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Value    : GLfloat_Vector_4)
   is
      procedure Imported
       (Context_Identifier  : WASM.Objects.Object_Identifier;
        Location_Identifier : WASM.Objects.Object_Identifier;
        Value_Address       : System.Address)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__uniform4fv";

   begin
      Imported
       (Self.Identifier, Location.Identifier, Value (Value'First)'Address);
   end Uniform_4fv;

   ------------------------
   -- Uniform_Matrix_2fv --
   ------------------------

   procedure Uniform_Matrix_2fv
    (Self      : in out WebGL_Rendering_Context'Class;
     Location  : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Transpose : Boolean;
     Value     : GLfloat_Matrix_2x2)
   is
      procedure Imported
       (Context_Identifier  : WASM.Objects.Object_Identifier;
        Location_Identifier : WASM.Objects.Object_Identifier;
        Transpose           : Interfaces.Unsigned_32;
        Value_Address       : System.Address)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__uniformMatrix2fv";

   begin
      Imported
       (Self.Identifier,
        Location.Identifier,
        Boolean'Pos (Transpose),
        Value (Value'First (1), Value'First (2))'Address);
   end Uniform_Matrix_2fv;

   ------------------------
   -- Uniform_Matrix_3fv --
   ------------------------

   procedure Uniform_Matrix_3fv
    (Self      : in out WebGL_Rendering_Context'Class;
     Location  : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Transpose : Boolean;
     Value     : GLfloat_Matrix_3x3)
   is
      procedure Imported
       (Context_Identifier  : WASM.Objects.Object_Identifier;
        Location_Identifier : WASM.Objects.Object_Identifier;
        Transpose           : Interfaces.Unsigned_32;
        Value_Address       : System.Address)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__uniformMatrix3fv";

   begin
      Imported
       (Self.Identifier,
        Location.Identifier,
        Boolean'Pos (Transpose),
        Value (Value'First (1), Value'First (2))'Address);
   end Uniform_Matrix_3fv;

   ------------------------
   -- Uniform_Matrix_4fv --
   ------------------------

   procedure Uniform_Matrix_4fv
    (Self      : in out WebGL_Rendering_Context'Class;
     Location  : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Transpose : Boolean;
     Value     : GLfloat_Matrix_4x4)
   is
      procedure Imported
       (Context_Identifier  : WASM.Objects.Object_Identifier;
        Location_Identifier : WASM.Objects.Object_Identifier;
        Transpose           : Interfaces.Unsigned_32;
        Value_Address       : System.Address)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__uniformMatrix4fv";

   begin
      Imported
       (Self.Identifier,
        Location.Identifier,
        Boolean'Pos (Transpose),
        Value (Value'First (1), Value'First (2))'Address);
   end Uniform_Matrix_4fv;

   -----------------
   -- Use_Program --
   -----------------

   procedure Use_Program
    (Self    : in out WebGL_Rendering_Context'Class;
     Program : Web.GL.Programs.WebGL_Program'Class)
   is
      procedure Imported
       (Context_Identifier : WASM.Objects.Object_Identifier;
        Program_Identifier : WASM.Objects.Object_Identifier)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__useProgram";

   begin
      Imported (Self.Identifier, Program.Identifier);
   end Use_Program;

   ---------------------------
   -- Vertex_Attrib_Pointer --
   ---------------------------

   procedure Vertex_Attrib_Pointer
    (Self       : in out WebGL_Rendering_Context'Class;
     Index      : GLuint;
     Size       : GLint;
     Data_Type  : GLenum;
     Normalized : Boolean;
     Stride     : GLsizei;
     Offset     : GLintptr)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Index      : GLuint;
        Size       : GLint;
        Data_Type  : GLenum;
        Normalized : Interfaces.Unsigned_32;
        Stride     : GLsizei;
        Offset     : GLintptr)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__vertexAttribPointer";

   begin
      Imported
       (Self.Identifier,
        Index,
        Size,
        Data_Type,
        Boolean'Pos (Normalized),
        Stride,
        Offset);
   end Vertex_Attrib_Pointer;

   --------------
   -- Viewport --
   --------------

   procedure Viewport
    (Self   : in out WebGL_Rendering_Context'Class;
     X      : GLint;
     Y      : GLint;
     Width  : GLsizei;
     Height : GLsizei)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        X      : GLint;
        Y      : GLint;
        Width  : GLsizei;
        Height : GLsizei)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__webgl__RenderingContext__viewport";

   begin
      Imported (Self.Identifier, X, Y, Width, Height);
   end Viewport;

end Web.GL.Rendering_Contexts;
