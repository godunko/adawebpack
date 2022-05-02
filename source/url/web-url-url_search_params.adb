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

with WASM.Classes;
with WASM.Methods;
with WASM.Objects.Constructors;
with WASM.Objects.Methods;

package body Web.URL.URL_Search_Params is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ---------------------------
      -- New_URL_Search_Params --
      ---------------------------

      function New_URL_Search_Params return URL_Search_Params is
      begin
         return
           Web.URL.URL_Search_Params.Instantiate
            (WASM.Objects.Constructors.New_Object
              (WASM.Classes.URL_Search_Params));
      end New_URL_Search_Params;

   end Constructors;

   ---------
   -- Get --
   ---------

   function Get
    (Self : URL_Search_Params'Class;
     Name : Web.Strings.Web_String) return Web.Strings.Web_String is
   begin
      return
        WASM.Objects.Methods.Call_String_String (Self, WASM.Methods.Get, Name);
   end Get;

   ---------
   -- Set --
   ---------

   procedure Set
     (Self  : in out URL_Search_Params'Class;
      Name  : Web.Strings.Web_String;
      Value : Web.Strings.Web_String) is
   begin
      WASM.Objects.Methods.Call_Void_String_String
        (Self, WASM.Methods.Set, Name, Value);
   end Set;

end Web.URL.URL_Search_Params;
