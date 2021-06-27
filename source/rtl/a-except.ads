------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--                       A D A . E X C E P T I O N S                        --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
-- This specification is derived from the Ada Reference Manual for use with --
-- GNAT.  In accordance with the copyright of that document, you can freely --
-- copy and modify this specification,  provided that if you redistribute a --
-- modified version,  any changes that you have made are clearly indicated. --
--                                                                          --
------------------------------------------------------------------------------
--
--  Version is for use when there are no handlers in the partition (i.e. either
--  of Restriction No_Exception_Handlers or No_Exception_Propagation is set).

--  This is the WASM version of this package
--  XXX GNATLLVM: Raise_Exception is incorrectly inlined in s-fatflt.ads

with System;
with Ada.Streams;

package Ada.Exceptions is
   pragma Preelaborate;
   --  In accordance with Ada 2005 AI-362

   type Exception_Id is private;
   pragma Preelaborable_Initialization (Exception_Id);

   Null_Id : constant Exception_Id;

   procedure Raise_Exception (E : Exception_Id; Message : String := "");
   pragma No_Return (Raise_Exception);
   --  Unconditionally call __gnat_last_chance_handler.
   --  Note that the exception is still raised even if E is the null exception
   --  id. This is a deliberate simplification for this profile (the use of
   --  Raise_Exception with a null id is very rare in any case, and this way
   --  we avoid introducing Raise_Exception_Always and we also avoid the if
   --  test in Raise_Exception).

   type Exception_Occurrence is limited private;
   pragma Preelaborable_Initialization (Exception_Occurrence);

   procedure Reraise_Occurrence (X : Exception_Occurrence);
   Null_Occurrence : constant Exception_Occurrence;

private

   ------------------
   -- Exception_Id --
   ------------------

   type Exception_Id is access all System.Address;
   Null_Id : constant Exception_Id := null;

--   pragma Inline_Always (Raise_Exception);

   type Exception_Occurrence is access String;

   procedure Read_Exception_Occurrence
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Exception_Occurrence);

   procedure Write_Exception_Occurrence
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Exception_Occurrence);

   for Exception_Occurrence'Read use Read_Exception_Occurrence;
   for Exception_Occurrence'Write use Write_Exception_Occurrence;

   Null_Occurrence : constant Exception_Occurrence := null;

   procedure Raise_From_Controlled_Operation (X : Exception_Occurrence);
   pragma No_Return (Raise_From_Controlled_Operation);
   pragma Export
     (Ada, Raise_From_Controlled_Operation,
           "__gnat_raise_from_controlled_operation");
   --  Raise Program_Error, providing information about X (an exception raised
   --  during a controlled operation) in the exception message.

end Ada.Exceptions;
