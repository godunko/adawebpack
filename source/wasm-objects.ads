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
--  Support for passing of JavaScript objects to Ada/WASM application.
--
--  Unique identifier is generated and identifier:object mapping is stored
--  on JavaScript side which protects from release of the object by garbage
--  collectors. Generated identifier is passed to Ada side, and reference
--  counting is used to let JavaScript know when last reference is released.
------------------------------------------------------------------------------

private with Ada.Finalization;
private with Interfaces;

package WASM.Objects is

   pragma Preelaborate;

   type Object_Identifier is private;

   type Object_Reference is tagged private;

   function Identifier
     (Self : Object_Reference'Class) return Object_Identifier;
   --  Returns object identifier of given reference.

   function Instantiate
     (Identifier : Object_Identifier) return Object_Reference;
   --  Create and initialize instance of object reference for the object
   --  with given identifier.

private

   type Object_Identifier is new Interfaces.Unsigned_32;

   type Shared_Data is record
      Counter    : Interfaces.Unsigned_32 := 1;
      Identifier : Object_Identifier      := 0;
   end record;

   type Shared_Data_Access is access all Shared_Data;

   type Object_Reference is new Ada.Finalization.Controlled with record
      Shared : Shared_Data_Access;
   end record;

   overriding procedure Adjust (Self : in out Object_Reference);
   overriding procedure Finalize (Self : in out Object_Reference);

end WASM.Objects;
