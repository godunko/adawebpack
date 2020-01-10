
package body WASM.Objects is

   procedure Seize (Identifier : Object_Identifier)
     with Import => True, Link_Name => "__awasm_object_seize";

   procedure Release (Identifier : Object_Identifier)
     with Import => True, Link_Name => "__awasm_object_release";

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Object_Reference) is
   begin
      if Self.Identifier /= 0 then
         Seize (Self.Identifier);
      end if;
   end Adjust;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Object_Reference) is
   begin
      if Self.Identifier /= 0 then
         Release (Self.Identifier);
         Self.Identifier := 0;
      end if;
   end Finalize;

   -----------------
   -- Instantiate --
   -----------------

   function Instantiate
     (Identifier : Object_Identifier) return Object_Reference is
   begin
      Seize (Identifier);

      return (Ada.Finalization.Controlled with Identifier => Identifier);
   end Instantiate;

end WASM.Objects;
