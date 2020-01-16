
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
