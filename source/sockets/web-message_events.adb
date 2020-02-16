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

with System;

with WASM.Objects;

package body Web.Message_Events is

   ----------------------
   -- Data_Byte_Length --
   ----------------------

   function Data_Byte_Length
    (Self : Message_Event) return Ada.Streams.Stream_Element_Count
   is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
         return Interfaces.Unsigned_32
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__messageevents__MessageEvent__byteLength";

   begin
      return Ada.Streams.Stream_Element_Count (Imported (Self.Identifier));
   end Data_Byte_Length;

   ----------
   -- Read --
   ----------

   procedure Read
    (Self   : Message_Event;
     Data   : out Ada.Streams.Stream_Element_Array;
     Offset : Ada.Streams.Stream_Element_Offset := 0)
   is
      procedure Imported
       (Identifier : WASM.Objects.Object_Identifier;
        Address    : System.Address;
        Size       : Interfaces.Unsigned_32;
        Offset     : Interfaces.Unsigned_32)
          with Import     => True,
               Convention => C,
               Link_Name  =>
                 "__adawebpack__messageevents__MessageEvent__read";

   begin
      Imported
        (Identifier => Self.Identifier,
         Address    => Data'Address,
         Size       => Data'Length,
         Offset     => Interfaces.Unsigned_32 (Offset));
   end Read;

end Web.Message_Events;
