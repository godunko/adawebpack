
with Interfaces;

package Demo is

   function Calculate_Square_Root
    (Value : Interfaces.IEEE_Float_64) return Interfaces.IEEE_Float_64
       with Export      => True,
            Convention  => C,
            Link_Name   => "Calculate_Square_Root";

end Demo;
