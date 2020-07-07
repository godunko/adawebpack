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
--  Package to process strings.
------------------------------------------------------------------------------

private with Ada.Finalization;
private with Interfaces;

private with Web.Unicode;

package Web.Strings is

   pragma Preelaborate;

   type Web_String is tagged private;

   Empty_Web_String : constant Web_String;

   function Is_Empty (Self : Web_String'Class) return Boolean;

   function Length (Self : Web_String'Class) return Natural;

   procedure Clear (Self : in out Web_String'Class);
   --  Clears the contents of the string and makes it null.

   function To_Web_String (Item : Wide_Wide_String) return Web_String;

   function To_Wide_Wide_String (Self : Web_String) return Wide_Wide_String;

   function "=" (Left : Web_String; Right : Web_String) return Boolean;

   function "&" (Left : Web_String; Right : Web_String) return Web_String;

private

   type String_Data (Capacity : Interfaces.Unsigned_32) is record
      Counter : Interfaces.Unsigned_32 := 1;
      Size    : Interfaces.Unsigned_32;
      Length  : Natural;
      Data    : Web.Unicode.UTF16_Code_Unit_Array (0 .. Capacity);
   end record;

   type String_Data_Access is access all String_Data;

   type Web_String is new Ada.Finalization.Controlled with record
      Data : String_Data_Access;
   end record;

   overriding procedure Adjust (Self : in out Web_String);
   overriding procedure Finalize (Self : in out Web_String);

   Empty_Web_String : constant Web_String
     := (Ada.Finalization.Controlled with Data => null);

end Web.Strings;
