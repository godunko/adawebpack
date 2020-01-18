------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--    A D A . E X C E P T I O N S . L A S T _ C H A N C E _ H A N D L E R   --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 2012-2020, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  Default last chance handler for no propagation runtimes

with Ada.Unchecked_Conversion;
with Interfaces;

with System.Machine_Code;

procedure Ada.Exceptions.Last_Chance_Handler
  (Msg : System.Address; Line : Integer)
is

   function Strlen (Str : System.Address) return Interfaces.Unsigned_32;
   --  Return length of the nul-terminated string.

   ------------
   -- Strlen --
   ------------

   function Strlen (Str : System.Address) return Interfaces.Unsigned_32 is

      use type Interfaces.Unsigned_32;

      type C_String_Ptr is access String (1 .. Positive'Last);

      function To_C_String_Ptr is new Ada.Unchecked_Conversion
        (System.Address, C_String_Ptr);

      Msg_Str : constant C_String_Ptr := To_C_String_Ptr (Str);
      Msg_Len : Interfaces.Unsigned_32 := 0;

   begin
      for J in Msg_Str'Range loop
         exit when Msg_Str (J) = Character'Val (0);

         Msg_Len := Msg_Len + 1;
      end loop;

      return Msg_Len;
   end Strlen;

   procedure Put_Exception
     (Address : System.Address;
      Size    : Interfaces.Unsigned_32;
      Line    : Interfaces.Unsigned_32)
        with Import     => True,
             Convention => C,
             Link_Name  => "__gnat_put_exception";

begin
   Put_Exception (Msg, Strlen (Msg), Interfaces.Unsigned_32 (Line));

   --  Stop the program

   System.Machine_Code.Asm ("unreachable", Volatile => True);
   --  Execution of "unreachable" aborts execution unconditionally. Raise
   --  statement below present just to prevent compiler's error.

   raise Program_Error;
end Ada.Exceptions.Last_Chance_Handler;
