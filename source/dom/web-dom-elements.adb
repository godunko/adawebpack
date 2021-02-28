------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2020-2021, Vadim Godunko                                    --
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

with WASM.Attributes;
with WASM.Objects.Attributes;

package body Web.DOM.Elements is

   --------------------
   -- Get_Class_List --
   --------------------

   function Get_Class_List
    (Self : Element'Class) return Web.DOM.Token_Lists.DOM_Token_List
   is
      function Imported
       (Element : WASM.Objects.Object_Identifier)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__dom__Element__classList_getter";

   begin
      return Web.DOM.Token_Lists.Instantiate (Imported (Self.Identifier));
   end Get_Class_List;

   ----------------------
   -- Get_Client_Height --
   ----------------------

   function Get_Client_Height (Self : Element'Class) return Web.DOM_Long is
      function Imported
       (Element : WASM.Objects.Object_Identifier)
          return Interfaces.Integer_32
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__cssom__Element__clientHeight_getter";

   begin
      return Imported (Self.Identifier);
   end Get_Client_Height;

   ----------------------
   -- Get_Client_Width --
   ----------------------

   function Get_Client_Width (Self : Element'Class) return Web.DOM_Long is
      function Imported
       (Element : WASM.Objects.Object_Identifier)
          return Interfaces.Integer_32
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__cssom__Element__clientWidth_getter";

   begin
      return Imported (Self.Identifier);
   end Get_Client_Width;

   ------------
   -- Get_Id --
   ------------

   function Get_Id (Self : Element'Class) return Web.Strings.Web_String is
   begin
      return WASM.Objects.Attributes.Get_String (Self, WASM.Attributes.Id);
   end Get_Id;

   ------------
   -- Set_Id --
   ------------

   procedure Set_Id
    (Self : in out Element'Class;
     To   : Web.Strings.Web_String) is
   begin
      WASM.Objects.Attributes.Set_String (Self, WASM.Attributes.Id, To);
   end Set_Id;

end Web.DOM.Elements;
