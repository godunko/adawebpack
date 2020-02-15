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
-- Copyright © 2017-2020, Vadim Godunko <vgodunko@gmail.com>                --
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

with WASM.Objects;

package Web.HTML.Validity_States is

   pragma Preelaborate;

   type Validity_State is new WASM.Objects.Object_Reference with null record;

--  interface ValidityState {
--    readonly attribute boolean valueMissing;
--    readonly attribute boolean typeMismatch;
--    readonly attribute boolean patternMismatch;
--    readonly attribute boolean tooLong;
--    readonly attribute boolean tooShort;
--    readonly attribute boolean stepMismatch;
--    readonly attribute boolean customError;
--  };

--   not overriding function Get_Value_Missing
--    (Self : not null access constant Validity_State)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "valueMissing";
--
--   not overriding function Get_Type_Mismatch
--    (Self : not null access constant Validity_State)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "typeMismatch";
--
--   not overriding function Get_Pattern_Mismatch
--    (Self : not null access constant Validity_State)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "patternMismatch";
--
--   not overriding function Get_Too_Long
--    (Self : not null access constant Validity_State)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "tooLong";
--
--   not overriding function Get_Too_Short
--    (Self : not null access constant Validity_State)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "tooShort";

   function Get_Range_Underflow (Self : Validity_State'Class) return Boolean;

   function Get_Range_Overflow (Self : Validity_State'Class) return Boolean;

--   not overriding function Get_Step_Mismatch
--    (Self : not null access constant Validity_State)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "stepMismatch";

   function Get_Bad_Input (Self : Validity_State'Class) return Boolean;

--   not overriding function Get_Custom_Error
--    (Self : not null access constant Validity_State)
--       return WebAPI.DOM_Boolean is abstract
--         with Import     => True,
--              Convention => JavaScript_Property_Getter,
--              Link_Name  => "customError";

   function Get_Valid (Self : Validity_State'Class) return Boolean;

end Web.HTML.Validity_States;
