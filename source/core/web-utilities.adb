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

with Web.Strings.WASM_Helpers;

package body Web.Utilities is

   --------------------
   -- Is_Instance_Of --
   --------------------

   function Is_Instance_Of
    (Object     : WASM.Objects.Object_Reference'Class;
     Class_Name : Web.Strings.Web_String) return Boolean
   is
      use type Interfaces.Unsigned_32;

      function Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Size       : Interfaces.Unsigned_32) return Interfaces.Unsigned_32
          with Import     => True,
               Convention => C,
               Link_Name  => "__adawebpack__is_instance_of";

      A : System.Address;
      S : Interfaces.Unsigned_32;

   begin
      Web.Strings.WASM_Helpers.To_JS (Class_Name, A, S);

      return Imported (Object.Identifier, A, S) /= 0;
   end Is_Instance_Of;

end Web.Utilities;
