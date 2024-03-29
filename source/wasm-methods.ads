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
--  This package define indicies of known object's methods to be used with
--  helper functions to call object's methods. See WASM.Objects.Methods for
--  more information.

with Interfaces;

package WASM.Methods is

   pragma Pure;

   type Method_Index is new Interfaces.Unsigned_32;

   --  This declaration must be synchronized with list of attributes' name in
   --  adawebpack.mjs file.

   Bind_Framebuffer         : constant := 0;
   Bind_Renderbuffer        : constant := 1;
   Clone_Node               : constant := 2;
   Create_Buffer            : constant := 3;
   Create_Framebuffer       : constant := 4;
   Create_Program           : constant := 5;
   Create_Renderbuffer      : constant := 6;
   Create_Texture           : constant := 7;
   Delete_Framebuffer       : constant := 8;
   Framebuffer_Renderbuffer : constant := 9;
   Framebuffer_Texture_2D   : constant := 10;
   Get                      : constant := 11;
   Get_Element_By_Id        : constant := 12;
   Has                      : constant := 13;
   Named_Item               : constant := 14;
   Renderbuffer_Storage     : constant := 15;
   Send                     : constant := 16;
   Set                      : constant := 17;
   Tex_Parameteri           : constant := 18;
   To_String                : constant := 19;

end WASM.Methods;
