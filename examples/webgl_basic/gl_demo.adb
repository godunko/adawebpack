
with Ada.Characters.Wide_Wide_Latin_1;

with Web.HTML.Canvases;
with Web.HTML.Scripts;
with Web.GL.Buffers;
with Web.GL.Programs;
with Web.GL.Rendering_Contexts;
with Web.GL.Shaders;
with Web.GL.Uniform_Locations;
with Web.Strings;
with Web.Window;

package body GL_Demo is

   use type Web.GL.GLfloat;
   use type Web.GL.GLsizeiptr;

   LF : constant Wide_Wide_Character := Ada.Characters.Wide_Wide_Latin_1.LF;

   function "+" (Item : Wide_Wide_String) return Web.Strings.Web_String
     renames Web.Strings.To_Web_String;

   procedure Initialize_Example;

   Positions : constant array (Positive range <>) of Web.GL.GLfloat
     := (-1.0,  1.0,
          1.0,  1.0,
         -1.0, -1.0,
          1.0, -1.0);

   Projection : constant Web.GL.GLfloat_Matrix_4x4
     := ((1.8106601238250732, 0.0, 0.0, 0.0),
         (0.0, 2.4142136573791504, 0.0, 0.0),
         (0.0, 0.0, -1.0020020008087158, -0.20020020008087158),
         (0.0, 0.0, -1.0, 0.0));

   Model_View : constant Web.GL.GLfloat_Matrix_4x4
     := ((1.0, 0.0, 0.0, 0.0),
         (0.0, 1.0, 0.0, 0.0),
         (0.0, 0.0, 1.0, -6.0),
         (0.0, 0.0, 0.0, 1.0));

   VS : Web.GL.Shaders.WebGL_Shader;
   FS : Web.GL.Shaders.WebGL_Shader;
   SP : Web.GL.Programs.WebGL_Program;

   Vertex_Position   : Web.GL.GLint;
   Projection_Matrix : Web.GL.Uniform_Locations.WebGL_Uniform_Location;
   Model_View_Matrix : Web.GL.Uniform_Locations.WebGL_Uniform_Location;

   Buffer : Web.GL.Buffers.WebGL_Buffer;

   GL : Web.GL.Rendering_Contexts.WebGL_Rendering_Context;

   ------------------------
   -- Initialize_Example --
   ------------------------

   procedure Initialize_Example is
   begin
      GL :=
        Web.Window.Document.Get_Element_By_Id
         (+"glcanvas").As_HTML_Canvas.Get_Context (+"webgl");

      GL.Clear_Color (0.0, 0.0, 0.0, 1.0);
      GL.Clear (Web.GL.Rendering_Contexts.COLOR_BUFFER_BIT);

      VS := GL.Create_Shader (Web.GL.Rendering_Contexts.VERTEX_SHADER);
      GL.Shader_Source
       (VS,
        Web.Window.Document.Get_Element_By_Id
         (+"vertex-shader").As_HTML_Script.Get_Text);
      GL.Compile_Shader (VS);

      FS := GL.Create_Shader (Web.GL.Rendering_Contexts.FRAGMENT_SHADER);
      GL.Shader_Source
       (FS,
        Web.Window.Document.Get_Element_By_Id
         (+"fragment-shader").As_HTML_Script.Get_Text);
      GL.Compile_Shader (FS);

      SP := GL.Create_Program;
      GL.Attach_Shader (SP, VS);
      GL.Attach_Shader (SP, FS);
      GL.Link_Program (SP);

      Vertex_Position := GL.Get_Attrib_Location (SP, +"aVertexPosition");
      Projection_Matrix := GL.Get_Uniform_Location (SP, +"uProjectionMatrix");
      Model_View_Matrix := GL.Get_Uniform_Location (SP, +"uModelViewMatrix");

      Buffer := GL.Create_Buffer;
      GL.Bind_Buffer (Web.GL.Rendering_Contexts.ARRAY_BUFFER, Buffer);
      GL.Buffer_Data
       (Web.GL.Rendering_Contexts.ARRAY_BUFFER,
        Positions'Length * Web.GL.GLfloat'Max_Size_In_Storage_Elements,
        Positions (Positions'First)'Address,
        Web.GL.Rendering_Contexts.STATIC_DRAW);

      GL.Bind_Buffer (Web.GL.Rendering_Contexts.ARRAY_BUFFER, Buffer);
      GL.Vertex_Attrib_Pointer
       (Web.GL.GLuint (Vertex_Position),
        2,
        Web.GL.Rendering_Contexts.FLOAT,
        False,
        0,
        0);
      GL.Enable_Vertex_Attrib_Array (Web.GL.GLuint (Vertex_Position));

      GL.Use_Program (SP);
      GL.Uniform_Matrix_4fv (Projection_Matrix, False, Projection);
      GL.Uniform_Matrix_4fv (Model_View_Matrix, False, Model_View);

      GL.Draw_Arrays (Web.GL.Rendering_Contexts.TRIANGLE_STRIP, 0, 4);
   end Initialize_Example;

begin
   Initialize_Example;
end GL_Demo;
