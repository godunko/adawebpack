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

with Interfaces;
with System;

with WASM.Methods;
with WASM.Objects.Methods;
with Web.Strings.WASM_Helpers;

package body Web.DOM.Documents is

   ----------------------
   -- Create_Text_Node --
   ----------------------

   function Create_Text_Node
    (Self : in out Document'Class;
     Data : Web.Strings.Web_String) return Web.DOM.Texts.Text
   is
      function Internal
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Size       : Interfaces.Unsigned_32)
          return WASM.Objects.Object_Identifier
            with Import     => True,
                 Convention => C,
                 Link_Name  => "__adawebpack__dom__Document__createTextNode";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Data, A, S);

      return Web.DOM.Texts.Instantiate (Internal (Self.Identifier, A, S));
   end Create_Text_Node;

   -----------------------
   -- Get_Element_By_Id --
   -----------------------

   overriding function Get_Element_By_Id
    (Self       : Document;
     Element_Id : Web.Strings.Web_String) return Web.DOM.Elements.Element is
   begin
      return
        Web.DOM.Elements.Instantiate
         (WASM.Objects.Methods.Call_Object_String
           (Self, WASM.Methods.Get_Element_By_Id, Element_Id));
   end Get_Element_By_Id;

end Web.DOM.Documents;
