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
        Red   : GLclampf;
        Green : GLclampf;
        Blue  : GLclampf;
        Alpha : GLclampf)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__webgl__RenderingContext__clearColor";
   begin
      Imported (Self.Identifier, Red, Green, Blue, Alpha);
   end Clear_Color;

end Web.GL.Rendering_Contexts;
