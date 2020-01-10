--  Support for passing of JavaScript objects to Ada/WASM application.
--
--  Unique identifier is generated and identifier:object mapping is stored
--  on JavaScript side which protects from release of the object by garbage
--  collectors. Generated identifier is passed to Ada side, and reference
--  counting is used to let JavaScript know when last reference is released.

private with Ada.Finalization;
private with Interfaces;

package WASM.Objects is

   pragma Preelaborate;

   type Object_Identifier is private;

   type Object_Reference is tagged private;

   function Instantiate
     (Identifier : Object_Identifier) return Object_Reference;

private

   type Object_Identifier is new Interfaces.Unsigned_32;

   type Object_Reference is new Ada.Finalization.Controlled with record
      Identifier : Object_Identifier := 0;
   end record;

   overriding procedure Adjust (Self : in out Object_Reference);
   overriding procedure Finalize (Self : in out Object_Reference);

end WASM.Objects;
