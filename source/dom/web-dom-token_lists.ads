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

with Web.DOM.Nodes;
with Web.Strings;

package Web.DOM.Token_Lists is

   pragma Preelaborate;

   type DOM_Token_List is new Web.DOM.Nodes.Node with null record;

   --  [Exposed=Window]
   --  interface DOMTokenList {
   --    readonly attribute unsigned long length;
   --    getter DOMString? item(unsigned long index);
   --    boolean contains(DOMString token);
   --    [CEReactions] boolean toggle(DOMString token, optional boolean force);
   --    [CEReactions] boolean replace(DOMString token, DOMString newToken);
   --    boolean supports(DOMString token);
   --    [CEReactions] stringifier attribute DOMString value;
   --    iterable<DOMString>;
   --  };

   procedure Add
    (Self  : DOM_Token_List'Class;
     Token : Web.Strings.Web_String);
   --  Adds all arguments passed, except those already present.

   procedure Remove
    (Self  : DOM_Token_List'Class;
     Token : Web.Strings.Web_String);
   --  Removes arguments passed, if they are present.

end Web.DOM.Token_Lists;
