------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2014-2020, Vadim Godunko                                    --
--  All rights reserved.                                                    --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--                                                                          --
--  1. Redistributions of source code must retain the above copyright       --
--     notice, this list of conditions and the following disclaimer.        --
--                                                                          --
--  2. Redistributions in binary form must reproduce the above copyright    --
--     notice, this list of conditions and the following disclaimer in the  --
--     documentation and/or other materials provided with the distribution. --
--                                                                          --
--  3. Neither the name of the copyright holder nor the names of its        --
--     contributors may be used to endorse or promote products derived      --
--     from this software without specific prior written permission.        --
--                                                                          --
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS     --
--  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT       --
--  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR   --
--  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT    --
--  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,  --
--  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT        --
--  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,   --
--  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY   --
--  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT     --
--  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE   --
--  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.    --
------------------------------------------------------------------------------
--  This is root package to expose WebGL API to Ada applications.
------------------------------------------------------------------------------

with Interfaces;

package Web.GL is

   pragma Preelaborate;

   type GLenum is new Interfaces.Unsigned_32;

   type GLboolean is new Interfaces.Unsigned_8;

   type GLbitfield is new Interfaces.Unsigned_32;

   --  typedef byte           GLbyte;         /* 'byte' should be a signed 8 bit type. */

   --  typedef short          GLshort;

   type GLint is new Interfaces.Integer_32;
   subtype GLsizei is GLint range 0 .. GLint'Last;

   --  type GLintptr is new Interfaces.Integer_32;

   type GLsizeiptr is new Interfaces.Integer_32;
   --  type GLsizeiptr is new Interfaces.Integer_64;
   --  XXX i64 can't be passed to/from JavaScript, replace this type by i32
   --  which should be sufficient for WASM32.

   --  // Ideally the typedef below would use 'unsigned byte', but that doesn't currently exist in Web IDL.
   --  typedef octet          GLubyte;        /* 'octet' should be an unsigned 8 bit type. */

   --  typedef unsigned short GLushort;

   type GLuint is new Interfaces.Unsigned_32;

   type GLfloat is new Interfaces.IEEE_Float_32;
   subtype GLclampf is GLfloat range 0.0 .. 1.0;

   type GLfloat_Vector_2 is array (Positive range 1 .. 2) of GLfloat;
   type GLfloat_Vector_3 is array (Positive range 1 .. 3) of GLfloat;
   type GLfloat_Vector_4 is array (Positive range 1 .. 4) of GLfloat;

   type GLfloat_Matrix_2x2 is
     array (Positive range 1 .. 2, Positive range 1 .. 2) of GLfloat
       with Convention => Fortran;
   type GLfloat_Matrix_3x3 is
     array (Positive range 1 .. 3, Positive range 1 .. 3) of GLfloat
       with Convention => Fortran;
   type GLfloat_Matrix_4x4 is
     array (Positive range 1 .. 4, Positive range 1 .. 4) of GLfloat
       with Convention => Fortran;

private

   --  Some types has representation compatible with i32/f32/f64 data
   --  types of WebAssembly and may be used directly:
   --
   --   - GLbitfield
   --   - GLclampf (validity should be checked)
   --   - GLenum
   --   - GLfloat
   --   - GLint
   --   - GLintptr
   --   - GLsizei
   --   - GLsizeiptr
   --   - GLuint
   --
   --  While others requires type conversions:
   --
   --   - GLboolean
   --   - GLbyte
   --   - GLshort
   --   - GLubyte
   --   - GLushort

end Web.GL;
