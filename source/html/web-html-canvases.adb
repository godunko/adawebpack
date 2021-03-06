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

with Interfaces;
with System;

with WASM.Objects;

with Web.Strings.WASM_Helpers;

package body Web.HTML.Canvases is

   -----------------
   -- Get_Context --
   -----------------

   function Get_Context
    (Self       : HTML_Canvas_Element'Class;
     Context_Id : Web.Strings.Web_String)
       return Web.GL.Rendering_Contexts.WebGL_Rendering_Context
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Size       : Interfaces.Unsigned_32)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Canvas__getContext";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Context_Id, A, S);

      return
        Web.GL.Rendering_Contexts.Instantiate
         (Imported (Self.Identifier, A, S));
   end Get_Context;

   ----------------
   -- Get_Height --
   ----------------

   function Get_Height
    (Self : HTML_Canvas_Element'Class) return Web.DOM_Unsigned_Long
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Canvas__height_getter";

   begin
      return Imported (Self.Identifier);
   end Get_Height;

   ---------------
   -- Get_Width --
   ---------------

   function Get_Width
    (Self : HTML_Canvas_Element'Class) return Web.DOM_Unsigned_Long
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Canvas__width_getter";

   begin
      return Imported (Self.Identifier);
   end Get_Width;

   ----------------
   -- Set_Height --
   ----------------

   procedure Set_Height
    (Self : in out HTML_Canvas_Element'Class;
     To   : Web.DOM_Unsigned_Long)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        To         : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__html__Canvas__height_setter";

   begin
      Imported (Self.Identifier, To);
   end Set_Height;

   ---------------
   -- Set_Width --
   ---------------

   procedure Set_Width
    (Self : in out HTML_Canvas_Element'Class;
     To   : Web.DOM_Unsigned_Long)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        To         : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__html__Canvas__width_setter";

   begin
      Imported (Self.Identifier, To);
   end Set_Width;

end Web.HTML.Canvases;
