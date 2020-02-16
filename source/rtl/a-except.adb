--  Copyright (C) 2016 Free Software Foundation, Inc.
--
--  This file is free software; you can redistribute it and/or modify
--  it under terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 3, or (at your
--  option) any later version. This file is distributed in the hope
--  that it will be useful, but WITHOUT ANY WARRANTY; without even the
--  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
--  PURPOSE.
--
--  As a special exception under Section 7 of GPL version 3, you are
--  granted additional permissions described in the GCC Runtime
--  Library Exception, version 3.1, as published by the Free Software
--  Foundation.
--
--  You should have received a copy of the GNU General Public License
--  and a copy of the GCC Runtime Library Exception along with this
--  program; see the files COPYING3 and COPYING.RUNTIME respectively.
--  If not, see <http://www.gnu.org/licenses/>.

package body Ada.Exceptions is

   procedure Last_Chance_Handler
     (Message : System.Address; Line : Integer)
   with
     Import,
     Convention => C,
     External_Name => "__gnat_last_chance_handler",
     No_Return;

   procedure Raise_Exception (E : Exception_Id; Message : String := "")
   is
      pragma Unreferenced (E);
   begin
      --  pragma Warnings (Off);
      Last_Chance_Handler (Message'Address, 0);
      --  pragma Warnings (On);
   end Raise_Exception;

   -------------------------------
   -- Read_Exception_Occurrence --
   -------------------------------

   procedure Read_Exception_Occurrence
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Exception_Occurrence)
   is
      Text : constant String := String'Input (Stream);
   begin
      if Text = "" then
         Item := Null_Occurrence;
      else
         Item := new String'(Text);
      end if;
   end Read_Exception_Occurrence;

   ------------------------
   -- Reraise_Occurrence --
   ------------------------

   procedure Reraise_Occurrence (X : Exception_Occurrence) is
   begin
      if X /= Null_Occurrence then
         Raise_Exception (Program_Error'Identity, X.all & Character'Val (0));
      end if;
   end Reraise_Occurrence;

   --------------------------------
   -- Write_Exception_Occurrence --
   --------------------------------

   procedure Write_Exception_Occurrence
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Exception_Occurrence) is
   begin
      if Item = Null_Occurrence then
         String'Output (Stream, "");
      else
         String'Output (Stream, Item.all);
      end if;
   end Write_Exception_Occurrence;

end Ada.Exceptions;
