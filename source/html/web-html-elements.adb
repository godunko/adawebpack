------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright (c) 2020, Vadim Godunko                                       --
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

with WASM.Objects;

with Web.HTML.Buttons;

package body Web.HTML.Elements is

   --------------------
   -- As_HTML_Button --
   --------------------

   function As_HTML_Button
    (Self : HTML_Element'Class) return Web.HTML.Buttons.HTML_Button_Element is
   begin
      return Web.HTML.Buttons.Instantiate (Self.Identifier);
   end As_HTML_Button;

   ----------------
   -- Get_Hidden --
   ----------------

   function Get_Hidden (Self : HTML_Element'Class) return Boolean is
      use type Interfaces.Unsigned_32;

      function Imported
       (Element : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__html__Element__hidden_getter";
   begin
      return Imported (Self.Identifier) /= 0;
   end Get_Hidden;

   ----------------
   -- Set_Hidden --
   ----------------

   procedure Set_Hidden (Self : in out HTML_Element'Class; To : Boolean) is
      procedure Imported
       (Element : WASM.Objects.Object_Identifier; To : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__html__Element__hidden_setter";

   begin
      Imported (Self.Identifier, Boolean'Pos (To));
   end Set_Hidden;

end Web.HTML.Elements;
