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

with WASM.Objects;
with WASM.Stringifiers;

with Web.Strings;

package Web.URL.URL_Search_Params is

   pragma Preelaborate;

   type URL_Search_Params is
     new WASM.Objects.Object_Reference
       and WASM.Stringifiers.Expose_Stringifier with null record;

--  interface URLSearchParams {
--    constructor(optional (sequence<sequence<USVString>> or record<USVString, USVString> or USVString) init = "");
--
--    undefined append(USVString name, USVString value);
--    undefined delete(USVString name);
--    sequence<USVString> getAll(USVString name);
--    boolean has(USVString name);
--
--    undefined sort();
--
--    iterable<USVString, USVString>;
--  };

   function Get
    (Self : URL_Search_Params'Class;
     Name : Web.Strings.Web_String) return Web.Strings.Web_String;

   procedure Set
    (Self  : in out URL_Search_Params'Class;
     Name  : Web.Strings.Web_String;
     Value : Web.Strings.Web_String);

   function Has
     (Self : URL_Search_Params'Class;
      Name : Web.Strings.Web_String) return Boolean;

   package Constructors is

      function New_URL_Search_Params return URL_Search_Params;

      function New_URL_Search_Params
        (Init : Web.Strings.Web_String) return URL_Search_Params;

   end Constructors;

end Web.URL.URL_Search_Params;
