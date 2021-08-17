
with Ada.Numerics.Generic_Elementary_Functions;

package body Demo is

   package Elementary_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Interfaces.IEEE_Float_64);

   ---------------------------
   -- Calculate_Square_Root --
   ---------------------------

   function Calculate_Square_Root
    (Value : Interfaces.IEEE_Float_64) return Interfaces.IEEE_Float_64 is
   begin
     return Elementary_Functions.Sqrt (Value);
   end Calculate_Square_Root;

end Demo;
