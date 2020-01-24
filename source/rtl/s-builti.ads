------------------------------------------------------------------------------
--                                                                          --
--                  GNAT RUN-TIME LIBRARY (GNARL) COMPONENTS                --
--                                                                          --
--                             S Y S T E M . I N I T                        --
--                                                                          --
--                                   S p e c                                --
--                                                                          --
--             Copyright (C) 2020, Free Software Foundation, Inc.           --
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
-- GNARL was developed by the GNARL team at Florida State University.       --
-- Extensive contributions were provided by AdaCore.                        --
--                                                                          --
------------------------------------------------------------------------------

--  This package provides implementation of some builtins functions missing
--  in GNATLLVM compiler, but used by runtime.

with Interfaces;

package System.Builtins is

   function Builtin_Inf return Interfaces.IEEE_Float_64
     with Export, Convention => C, External_Name => "__builtin_inf";

   function Builtin_Inff return Interfaces.IEEE_Float_32
     with Export, Convention => C, External_Name => "__builtin_inff";

end System.Builtins;