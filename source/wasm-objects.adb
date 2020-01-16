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

with Ada.Unchecked_Deallocation;

package body WASM.Objects is

   use type Interfaces.Unsigned_32;

   procedure Release (Identifier : Object_Identifier)
     with Import     => True,
          Convention => C,
          Link_Name  => "__adawebpack__wasm__object_release";

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Object_Reference) is
   begin
      if Self.Shared /= null then
         Self.Shared.Counter := Self.Shared.Counter + 1;
      end if;
   end Adjust;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Object_Reference) is
      procedure Free is
        new Ada.Unchecked_Deallocation (Shared_Data, Shared_Data_Access);

   begin
      if Self.Shared /= null then
         Self.Shared.Counter := Self.Shared.Counter - 1;

         if Self.Shared.Counter = 0 then
            Release (Self.Shared.Identifier);
            Free (Self.Shared);
         end if;

         Self.Shared := null;
      end if;
   end Finalize;

   ----------------
   -- Identifier --
   ----------------

   function Identifier
     (Self : Object_Reference'Class) return Object_Identifier is
   begin
      if Self.Shared = null then
         return 0;

      else
         return Self.Shared.Identifier;
      end if;
   end Identifier;

   -----------------
   -- Instantiate --
   -----------------

   function Instantiate
     (Identifier : Object_Identifier) return Object_Reference is
   begin
      return
       (Ada.Finalization.Controlled
          with Shared =>
            new Shared_Data'(Counter => <>, Identifier => Identifier));
   end Instantiate;

end WASM.Objects;
