------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2022, Vadim Godunko                                         --
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

package body WASM.Objects.Constructors is

   ----------------
   -- New_Object --
   ----------------

   function New_Object
     (Class : WASM.Classes.Class_Index)
      return WASM.Objects.Object_Identifier
   is
      function Imported
        (Class : WASM.Classes.Class_Index)
         return WASM.Objects.Object_Identifier
           with Import     => True,
                Convention => C,
                Link_Name  => "__adawebpack___new_object";

   begin
      return Imported (Class);
   end New_Object;

   -----------------------
   -- New_Object_String --
   -----------------------

   function New_Object_String
     (Class     : WASM.Classes.Class_Index;
      Parameter : Web.Strings.Web_String)
      return WASM.Objects.Object_Identifier
   is
      function Imported
        (Class   : WASM.Classes.Class_Index;
         Address : System.Address;
         Size    : Interfaces.Unsigned_32)
         return WASM.Objects.Object_Identifier
           with Import     => True,
                Convention => C,
                Link_Name  => "__adawebpack___new_object_string";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Parameter, A, S);

      return Imported (Class, A, S);
   end New_Object_String;

end WASM.Objects.Constructors;
