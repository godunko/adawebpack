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

with WASM.Objects;

package body Web.Window is

   procedure Dispatch_Animation_Frame
    (Callback : System.Address;
     Time     : Web.DOM_High_Res_Time_Stamp)
       with Export     => True,
            Convention => C,
            Link_Name  =>
              "__adawebpack__html__Window__dispatch_animation_frame";

   ------------------------------
   -- Dispatch_Animation_Frame --
   ------------------------------

   procedure Dispatch_Animation_Frame
    (Callback : System.Address;
     Time     : Web.DOM_High_Res_Time_Stamp)
   is
      procedure C (Time : Web.DOM_High_Res_Time_Stamp)
        with Import, Convention => C, Address => Callback;

   begin
      C (Time);
   end Dispatch_Animation_Frame;

   --------------
   -- Document --
   --------------

   function Document return Web.HTML.Documents.Document is
      function Internal return WASM.Objects.Object_Identifier
        with Import     => True,
             Convention => C,
             Link_Name  => "__adawebpack__bom__window__document";

   begin
      return Web.HTML.Documents.Instantiate (Internal);
   end Document;

   ----------------------------
   -- Get_Device_Pixel_Ratio --
   ----------------------------

   function Get_Device_Pixel_Ratio return Web.DOM_Double is
      function Imported return Interfaces.IEEE_Float_64
        with Import     => True,
             Convention => C,
             Link_Name  =>
               "__adawebpack__cssom__Window__devicePixelRatio_getter";

   begin
      return Imported;
   end Get_Device_Pixel_Ratio;

   -----------------------------
   -- Request_Animation_Frame --
   -----------------------------

   function Request_Animation_Frame
    (Callback : not null Frame_Request_Callback) return Web.DOM_Unsigned_Long
   is
      function Imported
       (Callback : System.Address) return Web.DOM_Unsigned_Long
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__html__Window__requestAnimationFrame";

   begin
      return Imported (Callback.all'Address);
   end Request_Animation_Frame;

end Web.Window;
