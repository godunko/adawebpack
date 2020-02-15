------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                            Web API Definition                            --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2020, Vadim Godunko <vgodunko@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Vadim Godunko, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision: 5732 $ $Date: 2017-01-28 14:52:41 +0300 (Sat, 28 Jan 2017) $
------------------------------------------------------------------------------

package body Web.HTML.Validity_States is

   -------------------
   -- Get_Bad_Input --
   -------------------

   function Get_Bad_Input (Self : Validity_State) return Boolean is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__html__ValidityState__badInput_getter";

   begin
      return Imported (Self.Identifier) /= 0;
   end Get_Bad_Input;

   ---------------
   -- Get_Valid --
   ---------------

   function Get_Valid (Self : Validity_State'Class) return Boolean is
      function Imported
       (Identifier : WASM.Objects.Object_Identifier)
          return Interfaces.Unsigned_32
            with Import     => True,
                 Convention => C,
                 Link_Name  =>
                   "__adawebpack__html__ValidityState__valid_getter";

   begin
      return Imported (Self.Identifier) /= 0;
   end Get_Valid;

end Web.HTML.Validity_States;
