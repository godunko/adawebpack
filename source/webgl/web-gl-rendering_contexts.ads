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
--  
--  with WebAPI.HTML.Canvas_Elements;
--  with WebAPI.HTML.Rendering_Contexts;
--  
--  with WebAPI.WebGL.Framebuffers;
--  with WebAPI.WebGL.Renderbuffers;
--  with WebAPI.WebGL.Textures;

with System;

with WASM.Objects;

with Web.GL.Buffers;
with Web.GL.Programs;
with Web.GL.Shaders;
with Web.GL.Uniform_Locations;
with Web.Strings;

package Web.GL.Rendering_Contexts is

   pragma Preelaborate;

   type WebGL_Rendering_Context is
     new WASM.Objects.Object_Reference with null record;

   ---------------------
   -- ClearBufferMask --
   ---------------------

   DEPTH_BUFFER_BIT   : constant := 16#00000100#;
   STENCIL_BUFFER_BIT : constant := 16#00000400#;
   COLOR_BUFFER_BIT   : constant := 16#00004000#;

   ---------------
   -- BeginMode --
   ---------------

   POINTS         : constant := 16#0000#;
   LINES          : constant := 16#0001#;
   LINE_LOOP      : constant := 16#0002#;
   LINE_STRIP     : constant := 16#0003#;
   TRIANGLES      : constant := 16#0004#;
   TRIANGLE_STRIP : constant := 16#0005#;
   TRIANGLE_FAN   : constant := 16#0006#;

--    /* AlphaFunction (not supported in ES20) */
--    /*      NEVER */
--    /*      LESS */
--    /*      EQUAL */
--    /*      LEQUAL */
--    /*      GREATER */
--    /*      NOTEQUAL */
--    /*      GEQUAL */
--    /*      ALWAYS */

--   ------------------------
--   -- BlendingFactorDest --
--   ------------------------
--
--   ZERO                : constant := 16#0000#;
--   ONE                 : constant := 16#0001#;
--   SRC_COLOR           : constant := 16#0300#;
--   ONE_MINUS_SRC_COLOR : constant := 16#0301#;
--   SRC_ALPHA           : constant := 16#0302#;
--   ONE_MINUS_SRC_ALPHA : constant := 16#0303#;
--   DST_ALPHA           : constant := 16#0304#;
--   ONE_MINUS_DST_ALPHA : constant := 16#0305#;
--
--   -----------------------
--   -- BlendingFactorSrc --
--   -----------------------
--
--   DST_COLOR           : constant := 16#0306#;
--   ONE_MINUS_DST_COLOR : constant := 16#0307#;
--   SRC_ALPHA_SATURATE  : constant := 16#0308#;
--
----    /* BlendEquationSeparate */
----    const GLenum FUNC_ADD                       = 0x8006;
----    const GLenum BLEND_EQUATION                 = 0x8009;
----    const GLenum BLEND_EQUATION_RGB             = 0x8009;   /* same as BLEND_EQUATION */
----    const GLenum BLEND_EQUATION_ALPHA           = 0x883D;
----
----    /* BlendSubtract */
----    const GLenum FUNC_SUBTRACT                  = 0x800A;
----    const GLenum FUNC_REVERSE_SUBTRACT          = 0x800B;
----
----    /* Separate Blend Functions */
----    const GLenum BLEND_DST_RGB                  = 0x80C8;
----    const GLenum BLEND_SRC_RGB                  = 0x80C9;
----    const GLenum BLEND_DST_ALPHA                = 0x80CA;
----    const GLenum BLEND_SRC_ALPHA                = 0x80CB;
--   CONSTANT_COLOR           : constant := 16#8001#;
--   ONE_MINUS_CONSTANT_COLOR : constant := 16#8002#;
--   CONSTANT_ALPHA           : constant := 16#8003#;
--   ONE_MINUS_CONSTANT_ALPHA : constant := 16#8004#;
----    const GLenum BLEND_COLOR                    = 0x8005;

   --------------------
   -- Buffer Objects --
   --------------------

   ARRAY_BUFFER         : constant := 16#8892#;
   ELEMENT_ARRAY_BUFFER : constant := 16#8893#;
--    const GLenum ARRAY_BUFFER_BINDING           = 0x8894;
--    const GLenum ELEMENT_ARRAY_BUFFER_BINDING   = 0x8895;

--   STREAM_DRAW          : constant := 16#88E0#;
   STATIC_DRAW          : constant := 16#88E4#;
--   DYNAMIC_DRAW         : constant := 16#88E8#;
--
----    const GLenum BUFFER_SIZE                    = 0x8764;
----    const GLenum BUFFER_USAGE                   = 0x8765;
----
----    const GLenum CURRENT_VERTEX_ATTRIB          = 0x8626;
----
----    /* CullFaceMode */
----    const GLenum FRONT                          = 0x0404;
----    const GLenum BACK                           = 0x0405;
----    const GLenum FRONT_AND_BACK                 = 0x0408;
--
--   ---------------
--   -- EnableCap --
--   ---------------
--
----    /* TEXTURE_2D */
--   CULL_FACE                : constant := 16#0B44#;
--   BLEND                    : constant := 16#0BE2#;
--   DITHER                   : constant := 16#0BD0#;
--   STENCIL_TEST             : constant := 16#0B90#;
--   DEPTH_TEST               : constant := 16#0B71#;
--   SCISSOR_TEST             : constant := 16#0C11#;
--   POLYGON_OFFSET_FILL      : constant := 16#8037#;
--   SAMPLE_ALPHA_TO_COVERAGE : constant := 16#809E#;
--   SAMPLE_COVERAGE          : constant := 16#80A0#;
--
----    /* ErrorCode */
----    const GLenum NO_ERROR                       = 0;
----    const GLenum INVALID_ENUM                   = 0x0500;
----    const GLenum INVALID_VALUE                  = 0x0501;
----    const GLenum INVALID_OPERATION              = 0x0502;
----    const GLenum OUT_OF_MEMORY                  = 0x0505;
----
----    /* FrontFaceDirection */
----    const GLenum CW                             = 0x0900;
----    const GLenum CCW                            = 0x0901;
----
----    /* GetPName */
----    const GLenum LINE_WIDTH                     = 0x0B21;
----    const GLenum ALIASED_POINT_SIZE_RANGE       = 0x846D;
----    const GLenum ALIASED_LINE_WIDTH_RANGE       = 0x846E;
----    const GLenum CULL_FACE_MODE                 = 0x0B45;
----    const GLenum FRONT_FACE                     = 0x0B46;
----    const GLenum DEPTH_RANGE                    = 0x0B70;
----    const GLenum DEPTH_WRITEMASK                = 0x0B72;
----    const GLenum DEPTH_CLEAR_VALUE              = 0x0B73;
----    const GLenum DEPTH_FUNC                     = 0x0B74;
----    const GLenum STENCIL_CLEAR_VALUE            = 0x0B91;
----    const GLenum STENCIL_FUNC                   = 0x0B92;
----    const GLenum STENCIL_FAIL                   = 0x0B94;
----    const GLenum STENCIL_PASS_DEPTH_FAIL        = 0x0B95;
----    const GLenum STENCIL_PASS_DEPTH_PASS        = 0x0B96;
----    const GLenum STENCIL_REF                    = 0x0B97;
----    const GLenum STENCIL_VALUE_MASK             = 0x0B93;
----    const GLenum STENCIL_WRITEMASK              = 0x0B98;
----    const GLenum STENCIL_BACK_FUNC              = 0x8800;
----    const GLenum STENCIL_BACK_FAIL              = 0x8801;
----    const GLenum STENCIL_BACK_PASS_DEPTH_FAIL   = 0x8802;
----    const GLenum STENCIL_BACK_PASS_DEPTH_PASS   = 0x8803;
----    const GLenum STENCIL_BACK_REF               = 0x8CA3;
----    const GLenum STENCIL_BACK_VALUE_MASK        = 0x8CA4;
----    const GLenum STENCIL_BACK_WRITEMASK         = 0x8CA5;
----    const GLenum VIEWPORT                       = 0x0BA2;
----    const GLenum SCISSOR_BOX                    = 0x0C10;
----    /*      SCISSOR_TEST */
----    const GLenum COLOR_CLEAR_VALUE              = 0x0C22;
----    const GLenum COLOR_WRITEMASK                = 0x0C23;
----    const GLenum UNPACK_ALIGNMENT               = 0x0CF5;
----    const GLenum PACK_ALIGNMENT                 = 0x0D05;
----    const GLenum MAX_TEXTURE_SIZE               = 0x0D33;
----    const GLenum MAX_VIEWPORT_DIMS              = 0x0D3A;
----    const GLenum SUBPIXEL_BITS                  = 0x0D50;
----    const GLenum RED_BITS                       = 0x0D52;
----    const GLenum GREEN_BITS                     = 0x0D53;
----    const GLenum BLUE_BITS                      = 0x0D54;
----    const GLenum ALPHA_BITS                     = 0x0D55;
----    const GLenum DEPTH_BITS                     = 0x0D56;
----    const GLenum STENCIL_BITS                   = 0x0D57;
----    const GLenum POLYGON_OFFSET_UNITS           = 0x2A00;
----    /*      POLYGON_OFFSET_FILL */
----    const GLenum POLYGON_OFFSET_FACTOR          = 0x8038;
----    const GLenum TEXTURE_BINDING_2D             = 0x8069;
----    const GLenum SAMPLE_BUFFERS                 = 0x80A8;
----    const GLenum SAMPLES                        = 0x80A9;
----    const GLenum SAMPLE_COVERAGE_VALUE          = 0x80AA;
----    const GLenum SAMPLE_COVERAGE_INVERT         = 0x80AB;
----
----    /* GetTextureParameter */
----    /*      TEXTURE_MAG_FILTER */
----    /*      TEXTURE_MIN_FILTER */
----    /*      TEXTURE_WRAP_S */
----    /*      TEXTURE_WRAP_T */
----
----    const GLenum COMPRESSED_TEXTURE_FORMATS     = 0x86A3;
----
----    /* HintMode */
----    const GLenum DONT_CARE                      = 0x1100;
----    const GLenum FASTEST                        = 0x1101;
----    const GLenum NICEST                         = 0x1102;
----
----    /* HintTarget */
----    const GLenum GENERATE_MIPMAP_HINT            = 0x8192;

   --------------
   -- DataType --
   --------------

--    const GLenum INT                            = 0x1404;
--    const GLenum UNSIGNED_INT                   = 0x1405;
   BYTE           : constant := 16#1400#;
   UNSIGNED_BYTE  : constant := 16#1401#;
   SHORT          : constant := 16#1402#;
   UNSIGNED_SHORT : constant := 16#1403#;
   FLOAT          : constant := 16#1406#;

--   -----------------
--   -- PixelFormat --
--   -----------------
--
--   ALPHA           : constant := 16#1906#;
--   RGB             : constant := 16#1907#;
--   RGBA            : constant := 16#1908#;
--   LUMINANCE       : constant := 16#1909#;
--   LUMINANCE_ALPHA : constant := 16#190A#;
----    const GLenum DEPTH_COMPONENT                = 0x1902;
--
--   ---------------
--   -- PixelType --
--   ---------------
--
----    /*      UNSIGNED_BYTE */
--   UNSIGNED_SHORT_4_4_4_4 : constant := 16#8033#;
--   UNSIGNED_SHORT_5_5_5_1 : constant := 16#8034#;
--   UNSIGNED_SHORT_5_6_5   : constant := 16#8363#;

   -------------
   -- Shaders --
   -------------

   FRAGMENT_SHADER   : constant := 16#8B30#;
   VERTEX_SHADER     : constant := 16#8B31#;
----    const GLenum MAX_VERTEX_ATTRIBS               = 0x8869;
----    const GLenum MAX_VERTEX_UNIFORM_VECTORS       = 0x8DFB;
----    const GLenum MAX_VARYING_VECTORS              = 0x8DFC;
----    const GLenum MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D;
----    const GLenum MAX_VERTEX_TEXTURE_IMAGE_UNITS   = 0x8B4C;
----    const GLenum MAX_TEXTURE_IMAGE_UNITS          = 0x8872;
----    const GLenum MAX_FRAGMENT_UNIFORM_VECTORS     = 0x8DFD;
--   SHADER_TYPE       : constant := 16#8B4F#;
--   DELETE_STATUS     : constant := 16#8B80#;
--   LINK_STATUS       : constant := 16#8B82#;
--   VALIDATE_STATUS   : constant := 16#8B83#;
--   ATTACHED_SHADERS  : constant := 16#8B85#;
--   ACTIVE_UNIFORMS   : constant := 16#8B86#;
--   ACTIVE_ATTRIBUTES : constant := 16#8B89#;
----    const GLenum SHADING_LANGUAGE_VERSION         = 0x8B8C;
----    const GLenum CURRENT_PROGRAM                  = 0x8B8D;
--
--   -------------------------------------
--   -- StencilFunction / DepthFunction --
--   -------------------------------------
--
--   NEVER    : constant := 16#0200#;
--   LESS     : constant := 16#0201#;
--   EQUAL    : constant := 16#0202#;
--   LEQUAL   : constant := 16#0203#;
--   GREATER  : constant := 16#0204#;
--   NOTEQUAL : constant := 16#0205#;
--   GEQUAL   : constant := 16#0206#;
--   ALWAYS   : constant := 16#0207#;
--
----    /* StencilOp */
----    /*      ZERO */
----    const GLenum KEEP                           = 0x1E00;
----    const GLenum REPLACE                        = 0x1E01;
----    const GLenum INCR                           = 0x1E02;
----    const GLenum DECR                           = 0x1E03;
----    const GLenum INVERT                         = 0x150A;
----    const GLenum INCR_WRAP                      = 0x8507;
----    const GLenum DECR_WRAP                      = 0x8508;
----
----    /* StringName */
----    const GLenum VENDOR                         = 0x1F00;
----    const GLenum RENDERER                       = 0x1F01;
----    const GLenum VERSION                        = 0x1F02;
--
--   ----------------------
--   -- TextureMagFilter --
--   ----------------------
--
--   NEAREST : constant := 16#2600#;
--   LINEAR  : constant := 16#2601#;
--
--   ----------------------
--   -- TextureMinFilter --
--   ----------------------
--
--   --  NEAREST
--   --  LINEAR
--   NEAREST_MIPMAP_NEAREST : constant := 16#2700#;
--   LINEAR_MIPMAP_NEAREST  : constant := 16#2701#;
--   NEAREST_MIPMAP_LINEAR  : constant := 16#2702#;
--   LINEAR_MIPMAP_LINEAR   : constant := 16#2703#;
--
--   --------------------------
--   -- TextureParameterName --
--   --------------------------
--
--   TEXTURE_MAG_FILTER : constant := 16#2800#;
--   TEXTURE_MIN_FILTER : constant := 16#2801#;
--   TEXTURE_WRAP_S     : constant := 16#2802#;
--   TEXTURE_WRAP_T     : constant := 16#2803#;
--
--   -------------------
--   -- TextureTarget --
--   -------------------
--
--   TEXTURE_2D                  : constant := 16#0DE1#;
----    const GLenum TEXTURE                        = 0x1702;
--
--   TEXTURE_CUBE_MAP            : constant := 16#8513#;
----    const GLenum TEXTURE_BINDING_CUBE_MAP       = 0x8514;
--   TEXTURE_CUBE_MAP_POSITIVE_X : constant := 16#8515#;
--   TEXTURE_CUBE_MAP_NEGATIVE_X : constant := 16#8516#;
--   TEXTURE_CUBE_MAP_POSITIVE_Y : constant := 16#8517#;
--   TEXTURE_CUBE_MAP_NEGATIVE_Y : constant := 16#8518#;
--   TEXTURE_CUBE_MAP_POSITIVE_Z : constant := 16#8519#;
--   TEXTURE_CUBE_MAP_NEGATIVE_Z : constant := 16#851A#;
----    const GLenum MAX_CUBE_MAP_TEXTURE_SIZE      = 0x851C;
--
--   -----------------
--   -- TextureUnit --
--   -----------------
--
--   TEXTURE0      : constant := 16#84C0#;
--   TEXTURE1      : constant := 16#84C1#;
--   TEXTURE2      : constant := 16#84C2#;
--   TEXTURE3      : constant := 16#84C3#;
--   TEXTURE4      : constant := 16#84C4#;
--   TEXTURE5      : constant := 16#84C5#;
--   TEXTURE6      : constant := 16#84C6#;
--   TEXTURE7      : constant := 16#84C7#;
--   TEXTURE8      : constant := 16#84C8#;
--   TEXTURE9      : constant := 16#84C9#;
--   TEXTURE10     : constant := 16#84CA#;
--   TEXTURE11     : constant := 16#84CB#;
--   TEXTURE12     : constant := 16#84CC#;
--   TEXTURE13     : constant := 16#84CD#;
--   TEXTURE14     : constant := 16#84CE#;
--   TEXTURE15     : constant := 16#84CF#;
--   TEXTURE16     : constant := 16#84D0#;
--   TEXTURE17     : constant := 16#84D1#;
--   TEXTURE18     : constant := 16#84D2#;
--   TEXTURE19     : constant := 16#84D3#;
--   TEXTURE20     : constant := 16#84D4#;
--   TEXTURE21     : constant := 16#84D5#;
--   TEXTURE22     : constant := 16#84D6#;
--   TEXTURE23     : constant := 16#84D7#;
--   TEXTURE24     : constant := 16#84D8#;
--   TEXTURE25     : constant := 16#84D9#;
--   TEXTURE26     : constant := 16#84DA#;
--   TEXTURE27     : constant := 16#84DB#;
--   TEXTURE28     : constant := 16#84DC#;
--   TEXTURE29     : constant := 16#84DD#;
--   TEXTURE30     : constant := 16#84DE#;
--   TEXTURE31     : constant := 16#84DF#;
----    const GLenum ACTIVE_TEXTURE                 = 0x84E0;
--
--   ---------------------
--   -- TextureWrapMode --
--   ---------------------
--
--   REPEAT          : constant := 16#2901#;
--   CLAMP_TO_EDGE   : constant := 16#812F#;
--   MIRRORED_REPEAT : constant := 16#8370#;
--
----    /* Uniform Types */
----    const GLenum FLOAT_VEC2                     = 0x8B50;
----    const GLenum FLOAT_VEC3                     = 0x8B51;
----    const GLenum FLOAT_VEC4                     = 0x8B52;
----    const GLenum INT_VEC2                       = 0x8B53;
----    const GLenum INT_VEC3                       = 0x8B54;
----    const GLenum INT_VEC4                       = 0x8B55;
----    const GLenum BOOL                           = 0x8B56;
----    const GLenum BOOL_VEC2                      = 0x8B57;
----    const GLenum BOOL_VEC3                      = 0x8B58;
----    const GLenum BOOL_VEC4                      = 0x8B59;
----    const GLenum FLOAT_MAT2                     = 0x8B5A;
----    const GLenum FLOAT_MAT3                     = 0x8B5B;
----    const GLenum FLOAT_MAT4                     = 0x8B5C;
----    const GLenum SAMPLER_2D                     = 0x8B5E;
----    const GLenum SAMPLER_CUBE                   = 0x8B60;
----
----    /* Vertex Arrays */
----    const GLenum VERTEX_ATTRIB_ARRAY_ENABLED        = 0x8622;
----    const GLenum VERTEX_ATTRIB_ARRAY_SIZE           = 0x8623;
----    const GLenum VERTEX_ATTRIB_ARRAY_STRIDE         = 0x8624;
----    const GLenum VERTEX_ATTRIB_ARRAY_TYPE           = 0x8625;
----    const GLenum VERTEX_ATTRIB_ARRAY_NORMALIZED     = 0x886A;
----    const GLenum VERTEX_ATTRIB_ARRAY_POINTER        = 0x8645;
----    const GLenum VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F;
----
----    /* Read Format */
----    const GLenum IMPLEMENTATION_COLOR_READ_TYPE   = 0x8B9A;
----    const GLenum IMPLEMENTATION_COLOR_READ_FORMAT = 0x8B9B;
--
--   -------------------
--   -- Shader Source --
--   -------------------
--
--   COMPILE_STATUS : constant := 16#8B81#;
--
----    /* Shader Precision-Specified Types */
----    const GLenum LOW_FLOAT                      = 0x8DF0;
----    const GLenum MEDIUM_FLOAT                   = 0x8DF1;
----    const GLenum HIGH_FLOAT                     = 0x8DF2;
----    const GLenum LOW_INT                        = 0x8DF3;
----    const GLenum MEDIUM_INT                     = 0x8DF4;
----    const GLenum HIGH_INT                       = 0x8DF5;
--
--   ------------------------
--   -- Framebuffer Object --
--   ------------------------
--
--   FRAMEBUFFER  : constant := 16#8D40#;
--   RENDERBUFFER : constant := 16#8D41#;
--
--   RGBA4             : constant := 16#8056#;
--   RGB5_A1           : constant := 16#8057#;
--   RGB565            : constant := 16#8D62#;
--   DEPTH_COMPONENT16 : constant := 16#81A5#;
--   STENCIL_INDEX8    : constant := 16#8D48#;
----    const GLenum STENCIL_INDEX                  = 0x1901;
----    const GLenum DEPTH_STENCIL                  = 0x84F9;
--
----    const GLenum RENDERBUFFER_WIDTH             = 0x8D42;
----    const GLenum RENDERBUFFER_HEIGHT            = 0x8D43;
----    const GLenum RENDERBUFFER_INTERNAL_FORMAT   = 0x8D44;
----    const GLenum RENDERBUFFER_RED_SIZE          = 0x8D50;
----    const GLenum RENDERBUFFER_GREEN_SIZE        = 0x8D51;
----    const GLenum RENDERBUFFER_BLUE_SIZE         = 0x8D52;
----    const GLenum RENDERBUFFER_ALPHA_SIZE        = 0x8D53;
----    const GLenum RENDERBUFFER_DEPTH_SIZE        = 0x8D54;
----    const GLenum RENDERBUFFER_STENCIL_SIZE      = 0x8D55;
----
----    const GLenum FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE           = 0x8CD0;
----    const GLenum FRAMEBUFFER_ATTACHMENT_OBJECT_NAME           = 0x8CD1;
----    const GLenum FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL         = 0x8CD2;
----    const GLenum FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3;
--
--   COLOR_ATTACHMENT0  : constant := 16#8CE0#;
--   DEPTH_ATTACHMENT   : constant := 16#8D00#;
--   STENCIL_ATTACHMENT : constant := 16#8D20#;
----    const GLenum DEPTH_STENCIL_ATTACHMENT       = 0x821A;
--
----    const GLenum NONE                           = 0;
----
----    const GLenum FRAMEBUFFER_COMPLETE                      = 0x8CD5;
----    const GLenum FRAMEBUFFER_INCOMPLETE_ATTACHMENT         = 0x8CD6;
----    const GLenum FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7;
----    const GLenum FRAMEBUFFER_INCOMPLETE_DIMENSIONS         = 0x8CD9;
----    const GLenum FRAMEBUFFER_UNSUPPORTED                   = 0x8CDD;
----
----    const GLenum FRAMEBUFFER_BINDING            = 0x8CA6;
----    const GLenum RENDERBUFFER_BINDING           = 0x8CA7;
----    const GLenum MAX_RENDERBUFFER_SIZE          = 0x84E8;
----
----    const GLenum INVALID_FRAMEBUFFER_OPERATION  = 0x0506;
----
----    /* WebGL-specific enums */
----    const GLenum UNPACK_FLIP_Y_WEBGL            = 0x9240;
----    const GLenum UNPACK_PREMULTIPLY_ALPHA_WEBGL = 0x9241;
----    const GLenum CONTEXT_LOST_WEBGL             = 0x9242;
----    const GLenum UNPACK_COLORSPACE_CONVERSION_WEBGL = 0x9243;
----    const GLenum BROWSER_DEFAULT_WEBGL          = 0x9244;
--
--   not overriding function Get_Canvas
--     (Self : not null access WebGL_Rendering_Context)
--        return WebAPI.HTML.Canvas_Elements.HTML_Canvas_Element_Access
--          is abstract
--            with Import     => True,
--                 Convention => JavaScript_Property_Getter,
--                 Link_Name  => "canvas";
--
----    readonly attribute GLsizei drawingBufferWidth;
----    readonly attribute GLsizei drawingBufferHeight;
----
----    [WebGLHandlesContextLoss] WebGLContextAttributes? getContextAttributes();
----    [WebGLHandlesContextLoss] boolean isContextLost();
----
----    sequence<DOMString>? getSupportedExtensions();
----    object? getExtension(DOMString name);
--
--   not overriding procedure Active_Texture
--    (Self    : not null access WebGL_Rendering_Context;
--     Texture : GLenum) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "activeTexture";

   procedure Attach_Shader
    (Self    : in out WebGL_Rendering_Context'Class;
     Program : in out Web.GL.Programs.WebGL_Program'Class;
     Shader  : in out Web.GL.Shaders.WebGL_Shader'Class);

--    void bindAttribLocation(WebGLProgram? program, GLuint index, DOMString name);

   procedure Bind_Buffer
    (Self   : in out WebGL_Rendering_Context'Class;
     Target : GLenum;
     Buffer : Web.GL.Buffers.WebGL_Buffer'Class);
--            Pre'Class  => Target in ARRAY_BUFFER | ELEMENT_ARRAY_BUFFER;

--   not overriding procedure Bind_Framebuffer
--    (Self        : not null access WebGL_Rendering_Context;
--     Target      : GLenum;
--     Framebuffer : access WebAPI.WebGL.Framebuffers.WebGL_Framebuffer'Class)
--       is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "bindFramebuffer";
----              Pre'Class  => Target in FRAMEBUFFER;
--
--   not overriding procedure Bind_Renderbuffer
--    (Self         : not null access WebGL_Rendering_Context;
--     Target       : GLenum;
--     Renderbuffer : access WebAPI.WebGL.Renderbuffers.WebGL_Renderbuffer'Class)
--       is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "bindRenderbuffer";
----              Pre'Class  => Target in RENDERBUFFER;
--
--   not overriding procedure Bind_Texture
--    (Self    : not null access WebGL_Rendering_Context;
--     Target  : GLenum;
--     Texture : access WebAPI.WebGL.Textures.WebGL_Texture'Class)
--       is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "bindTexture";
----              Pre'Class  => Target in TEXTURE_2D | TEXTURE_CUBE_MAP;
--
----    void blendColor(GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
----    void blendEquation(GLenum mode);
----    void blendEquationSeparate(GLenum modeRGB, GLenum modeAlpha);
--
--   not overriding procedure Blend_Func
--    (Self               : not null access WebGL_Rendering_Context;
--     Source_Factor      : GLenum;
--     Destination_Factor : GLenum)
--       is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "blendFunc";
--
----    void blendFuncSeparate(GLenum srcRGB, GLenum dstRGB,
----                           GLenum srcAlpha, GLenum dstAlpha);

--    typedef (ArrayBuffer or ArrayBufferView) BufferDataSource;
--    void bufferData(GLenum target, GLsizeiptr size, GLenum usage);
--    void bufferData(GLenum target, BufferDataSource? data, GLenum usage);
   procedure Buffer_Data
    (Self   : in out WebGL_Rendering_Context'Class;
     Target : Web.GL.GLenum;
     Size   : Web.GL.GLsizeiptr;
     Data   : System.Address;
     Usage  : Web.GL.GLenum);

----    void bufferSubData(GLenum target, GLintptr offset, BufferDataSource? data);
----
----    [WebGLHandlesContextLoss] GLenum checkFramebufferStatus(GLenum target);

   procedure Clear
    (Self : in out WebGL_Rendering_Context'Class;
     Mask : GLbitfield);

   procedure Clear_Color
    (Self  : in out WebGL_Rendering_Context'Class;
     Red   : GLclampf;
     Green : GLclampf;
     Blue  : GLclampf;
     Alpha : GLclampf);

----    void clearDepth(GLclampf depth);
----    void clearStencil(GLint s);
----    void colorMask(GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);

   procedure Compile_Shader
    (Self   : in out WebGL_Rendering_Context'Class;
     Shader : in out Web.GL.Shaders.WebGL_Shader'Class);

----    void compressedTexImage2D(GLenum target, GLint level, GLenum internalformat,
----                              GLsizei width, GLsizei height, GLint border,
----                              ArrayBufferView data);
----    void compressedTexSubImage2D(GLenum target, GLint level,
----                                 GLint xoffset, GLint yoffset,
----                                 GLsizei width, GLsizei height, GLenum format,
----                                 ArrayBufferView data);
----
----    void copyTexImage2D(GLenum target, GLint level, GLenum internalformat,
----                        GLint x, GLint y, GLsizei width, GLsizei height,
----                        GLint border);
----    void copyTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset,
----                           GLint x, GLint y, GLsizei width, GLsizei height);

   function Create_Buffer
    (Self : in out WebGL_Rendering_Context'Class)
       return Web.GL.Buffers.WebGL_Buffer;

--   not overriding function Create_Framebuffer
--    (Self : not null access WebGL_Rendering_Context)
--       return WebAPI.WebGL.Framebuffers.WebGL_Framebuffer_Access is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "createFramebuffer";

   function Create_Program
    (Self : in out WebGL_Rendering_Context'Class)
       return Web.GL.Programs.WebGL_Program;

--   not overriding function Create_Renderbuffer
--    (Self : not null access WebGL_Rendering_Context)
--       return WebAPI.WebGL.Renderbuffers.WebGL_Renderbuffer_Access is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "createRenderbuffer";

   function Create_Shader
    (Self     : in out WebGL_Rendering_Context'Class;
     The_Type : GLenum) return Web.GL.Shaders.WebGL_Shader;
--
--   not overriding function Create_Texture
--    (Self : not null access WebGL_Rendering_Context)
--       return WebAPI.WebGL.Textures.WebGL_Texture_Access is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "createTexture";
--
----    void cullFace(GLenum mode);
--
--   not overriding procedure Delete_Buffer
--    (Self   : not null access WebGL_Rendering_Context;
--     Buffer : access WebAPI.WebGL.Buffers.WebGL_Buffer'Class) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "deleteBuffer";
--
--   not overriding procedure Delete_Framebuffer
--    (Self        : not null access WebGL_Rendering_Context;
--     Framebuffer : access WebAPI.WebGL.Framebuffers.WebGL_Framebuffer'Class)
--       is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "deleteFramebuffer";
--
--   not overriding procedure Delete_Program
--    (Self    : not null access WebGL_Rendering_Context;
--     Program : access WebAPI.WebGL.Programs.WebGL_Program'Class) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "deleteProgram";
--
--   not overriding procedure Delete_Renderbuffer
--    (Self         : not null access WebGL_Rendering_Context;
--     Renderbuffer : access WebAPI.WebGL.Renderbuffers.WebGL_Renderbuffer'Class)
--       is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "deleteRenderbuffer";
--
--   not overriding procedure Delete_Shader
--    (Self   : not null access WebGL_Rendering_Context;
--     Shader : access WebAPI.WebGL.Shaders.WebGL_Shader'Class) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "deleteShader";
--
--   not overriding procedure Delete_Texture
--    (Self    : not null access WebGL_Rendering_Context;
--     Texture : access WebAPI.WebGL.Textures.WebGL_Texture'Class)
--       is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "deleteTexture";
--
--   not overriding procedure Depth_Func
--    (Self : not null access WebGL_Rendering_Context;
--     Func : GLenum) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "depthFunc";
--
----    void depthMask(GLboolean flag);
----    void depthRange(GLclampf zNear, GLclampf zFar);
----    void detachShader(WebGLProgram? program, WebGLShader? shader);
--
--   not overriding procedure Disable
--    (Self       : not null access WebGL_Rendering_Context;
--     Capability : GLenum) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "disable";
--
--   not overriding procedure Disable_Vertex_Attrib_Array
--    (Self  : not null access WebGL_Rendering_Context;
--     Index : GLuint) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "disableVertexAttribArray";

   procedure Draw_Arrays
    (Self  : WebGL_Rendering_Context'Class;
     Mode  : GLenum;
     First : GLint;
     Count : GLsizei);

----    void drawElements(GLenum mode, GLsizei count, GLenum type, GLintptr offset);
--
--   not overriding procedure Enable
--    (Self       : not null access WebGL_Rendering_Context;
--     Capability : GLenum) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "enable";

   procedure Enable_Vertex_Attrib_Array
    (Self  : in out WebGL_Rendering_Context;
     Index : GLuint);

--   not overriding procedure Finish
--    (Self : not null access WebGL_Rendering_Context) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "finish";
--
--   not overriding procedure Flush
--    (Self : not null access WebGL_Rendering_Context) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "flush";
--
--   not overriding procedure Framebuffer_Renderbuffer
--    (Self                : not null access WebGL_Rendering_Context;
--     Target              : WebAPI.WebGL.GLenum;
--     Attachment          : WebAPI.WebGL.GLenum;
--     Renderbuffer_Target : WebAPI.WebGL.GLenum;
--     Renderbuffer        :
--       WebAPI.WebGL.Renderbuffers.WebGL_Renderbuffer_Access) is abstract
--         with Import     => True,
--              Convention => JavaScript_Method,
--              Link_Name  => "framebufferRenderbuffer";
--
--   not overriding procedure Framebuffer_Texture_2D
--    (Self           : not null access WebGL_Rendering_Context;
--     Target         : WebAPI.WebGL.GLenum;
--     Attachment     : WebAPI.WebGL.GLenum;
--     Texture_Target : WebAPI.WebGL.GLenum;
--     Texture        : WebAPI.WebGL.Textures.WebGL_Texture_Access;
--     Level          : WebAPI.WebGL.GLint) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "framebufferTexture2D";
--
----    void frontFace(GLenum mode);
----
----    void generateMipmap(GLenum target);
----
----    WebGLActiveInfo? getActiveAttrib(WebGLProgram? program, GLuint index);
----    WebGLActiveInfo? getActiveUniform(WebGLProgram? program, GLuint index);
----    sequence<WebGLShader>? getAttachedShaders(WebGLProgram? program);

   function Get_Attrib_Location
    (Self    : WebGL_Rendering_Context'Class;
     Program : Web.GL.Programs.WebGL_Program'Class;
     Name    : Web.Strings.Web_String) return GLint;

----    any getBufferParameter(GLenum target, GLenum pname);
----    any getParameter(GLenum pname);
----
----    [WebGLHandlesContextLoss] GLenum getError();
----
----    any getFramebufferAttachmentParameter(GLenum target, GLenum attachment,
----                                          GLenum pname);
--
--   not overriding function Get_Program_Parameter
--    (Self    : not null access WebGL_Rendering_Context;
--     Program : access WebAPI.WebGL.Programs.WebGL_Program'Class;
--     Pname   : GLenum) return GLint is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "getProgramParameter";
----            Pre'Class  => Pname in ATTACHED_SHADERS | ACTIVE_ATTRIBUTES
----                                    | ACTIVE_UNIFORMS;
--   not overriding function Get_Program_Parameter
--    (Self    : not null access WebGL_Rendering_Context;
--     Program : access WebAPI.WebGL.Programs.WebGL_Program'Class;
--     Pname   : GLenum) return Boolean is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "getProgramParameter";
----            Pre'Class  => Pname in DELETE_STATUS | LINK_STATUS
----                                    | VALIDATE_STATUS;
--
----    DOMString? getProgramInfoLog(WebGLProgram? program);
----    any getRenderbufferParameter(GLenum target, GLenum pname);
--
--   not overriding function Get_Shader_Parameter
--    (Self   : not null access WebGL_Rendering_Context;
--     Shader : access WebAPI.WebGL.Shaders.WebGL_Shader'Class;
--     Pname  : GLenum) return GLenum is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "getShaderParameter";
----            Pre'Class  => Pname = SHADER_TYPE;
--   not overriding function Get_Shader_Parameter
--    (Self   : not null access WebGL_Rendering_Context;
--     Shader : access WebAPI.WebGL.Shaders.WebGL_Shader'Class;
--     Pname  : GLenum) return Boolean is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "getShaderParameter";
----            Pre'Class  => Pname in DELETE_STATUS | COMPILE_STATUS;
--
----    WebGLShaderPrecisionFormat? getShaderPrecisionFormat(GLenum shadertype, GLenum precisiontype);
----    DOMString? getShaderInfoLog(WebGLShader? shader);
----
----    DOMString? getShaderSource(WebGLShader? shader);
----
----    any getTexParameter(GLenum target, GLenum pname);
----
----    any getUniform(WebGLProgram? program, WebGLUniformLocation? location);

   function Get_Uniform_Location
    (Self    : WebGL_Rendering_Context'Class;
     Program : Web.GL.Programs.WebGL_Program'Class;
     Name    : Web.Strings.Web_String)
       return Web.GL.Uniform_Locations.WebGL_Uniform_Location;

----    any getVertexAttrib(GLuint index, GLenum pname);
----
----    [WebGLHandlesContextLoss] GLintptr getVertexAttribOffset(GLuint index, GLenum pname);
----
----    void hint(GLenum target, GLenum mode);
----    [WebGLHandlesContextLoss] GLboolean isBuffer(WebGLBuffer? buffer);
----    [WebGLHandlesContextLoss] GLboolean isEnabled(GLenum cap);
----    [WebGLHandlesContextLoss] GLboolean isFramebuffer(WebGLFramebuffer? framebuffer);
----    [WebGLHandlesContextLoss] GLboolean isProgram(WebGLProgram? program);
----    [WebGLHandlesContextLoss] GLboolean isRenderbuffer(WebGLRenderbuffer? renderbuffer);
----    [WebGLHandlesContextLoss] GLboolean isShader(WebGLShader? shader);
----    [WebGLHandlesContextLoss] GLboolean isTexture(WebGLTexture? texture);
----    void lineWidth(GLfloat width);

   procedure Link_Program
    (Self    : in out WebGL_Rendering_Context'Class;
     Program : in out Web.GL.Programs.WebGL_Program'Class);

----    void pixelStorei(GLenum pname, GLint param);
----    void polygonOffset(GLfloat factor, GLfloat units);
--
--   not overriding procedure Read_Pixels
--    (Self      : not null access WebGL_Rendering_Context;
--     X         : WebAPI.WebGL.Glint;
--     Y         : WebAPI.WebGL.Glint;
--     Width     : WebAPI.WebGL.Glsizei;
--     Height    : WebAPI.WebGL.Glsizei;
--     Format    : WebAPI.WebGL.GLenum;
--     Data_Type : WebAPI.WebGL.GLenum;
--     Pixels    : System.Address) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "readPixels";
--
--   not overriding procedure Renderbuffer_Storage
--    (Self   : not null access WebGL_Rendering_Context;
--     Target : WebAPI.WebGL.GLenum;
--     Format : WebAPI.WebGL.GLenum;
--     Width  : WebAPI.WebGL.Glsizei;
--     Height : WebAPI.WebGL.Glsizei) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "renderbufferStorage";
--
----    void sampleCoverage(GLclampf value, GLboolean invert);
----    void scissor(GLint x, GLint y, GLsizei width, GLsizei height);

   procedure Shader_Source
    (Self   : in out WebGL_Rendering_Context;
     Shader : in out Web.GL.Shaders.WebGL_Shader'Class;
     Source : Web.Strings.Web_String);

----    void stencilFunc(GLenum func, GLint ref, GLuint mask);
----    void stencilFuncSeparate(GLenum face, GLenum func, GLint ref, GLuint mask);
----    void stencilMask(GLuint mask);
----    void stencilMaskSeparate(GLenum face, GLuint mask);
----    void stencilOp(GLenum fail, GLenum zfail, GLenum zpass);
----    void stencilOpSeparate(GLenum face, GLenum fail, GLenum zfail, GLenum zpass);
----
----    typedef (ImageBitmap or
----             ImageData or
----             HTMLImageElement or
----             HTMLCanvasElement or
----             HTMLVideoElement) TexImageSource;
--
--   not overriding procedure Tex_Image_2D
--    (Self            : not null access WebGL_Rendering_Context;
--     Target          : WebAPI.WebGL.GLenum;
--     Level           : WebAPI.WebGL.GLint;
--     Internal_Format : WebAPI.WebGL.GLint;
--     Width           : WebAPI.WebGL.GLsizei;
--     Height          : WebAPI.WebGL.GLsizei;
--     Border          : WebAPI.WebGL.GLint;
--     Format          : WebAPI.WebGL.GLenum;
--     Data_Type       : WebAPI.WebGL.GLenum;
--     Pixels          : System.Address) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "texImage2D";
--
----    void texImage2D(GLenum target, GLint level, GLint internalformat,
----                    GLenum format, GLenum type, TexImageSource? source); // May throw DOMException
--
--   not overriding procedure Tex_Parameterf
--    (Self   : not null access WebGL_Rendering_Context;
--     Target : WebAPI.WebGL.GLenum;
--     Pname  : WebAPI.WebGL.GLenum;
--     Value  : WebAPI.WebGL.GLfloat) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "texParameterf";
--
--   not overriding procedure Tex_Parameteri
--    (Self   : not null access WebGL_Rendering_Context;
--     Target : WebAPI.WebGL.GLenum;
--     Pname  : WebAPI.WebGL.GLenum;
--     Value  : WebAPI.WebGL.GLint) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "texParameteri";
--
----    void texSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset,
----                       GLsizei width, GLsizei height,
----                       GLenum format, GLenum type, ArrayBufferView? pixels);
----    void texSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset,
----                       GLenum format, GLenum type, TexImageSource? source); // May throw DOMException

   procedure Uniform_1f
    (Self     : in out WebGL_Rendering_Context'Class;
     Location : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     X        : GLfloat);

--    void uniform1fv(WebGLUniformLocation? location, Float32Array v);
--    void uniform1fv(WebGLUniformLocation? location, sequence<GLfloat> v);

   procedure Uniform_1i
    (Self     : in out WebGL_Rendering_Context'Class;
     Location : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     X        : GLint);

--    void uniform1iv(WebGLUniformLocation? location, Int32Array v);
--    void uniform1iv(WebGLUniformLocation? location, sequence<long> v);

--   not overriding procedure Uniform_2f
--    (Self     : not null access WebGL_Rendering_Context;
--     Location : WebAPI.WebGL.Uniform_Locations.WebGL_Uniform_Location_Access;
--     X        : GLfloat;
--     Y        : GLfloat) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "uniform2f";

   procedure Uniform_2fv
    (Self     : in out WebGL_Rendering_Context'Class;
     Location : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Value    : GLfloat_Vector_2);

--    void uniform2fv(WebGLUniformLocation? location, sequence<GLfloat> v);
--    void uniform2i(WebGLUniformLocation? location, GLint x, GLint y);
--    void uniform2iv(WebGLUniformLocation? location, Int32Array v);
--    void uniform2iv(WebGLUniformLocation? location, sequence<long> v);

--   not overriding procedure Uniform_3f
--    (Self     : not null access WebGL_Rendering_Context;
--     Location : WebAPI.WebGL.Uniform_Locations.WebGL_Uniform_Location_Access;
--     X        : GLfloat;
--     Y        : GLfloat;
--     Z        : GLfloat) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "uniform3f";

   procedure Uniform_3fv
    (Self     : in out WebGL_Rendering_Context'Class;
     Location : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Value    : GLfloat_Vector_3);

--    void uniform3fv(WebGLUniformLocation? location, sequence<GLfloat> v);
--    void uniform3i(WebGLUniformLocation? location, GLint x, GLint y, GLint z);
--    void uniform3iv(WebGLUniformLocation? location, Int32Array v);
--    void uniform3iv(WebGLUniformLocation? location, sequence<long> v);

--   not overriding procedure Uniform_4f
--    (Self     : not null access WebGL_Rendering_Context;
--     Location : WebAPI.WebGL.Uniform_Locations.WebGL_Uniform_Location_Access;
--     X        : GLfloat;
--     Y        : GLfloat;
--     Z        : GLfloat;
--     W        : GLfloat) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "uniform4f";

   procedure Uniform_4fv
    (Self     : in out WebGL_Rendering_Context'Class;
     Location : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Value    : GLfloat_Vector_4);

--    void uniform4fv(WebGLUniformLocation? location, sequence<GLfloat> v);
--    void uniform4i(WebGLUniformLocation? location, GLint x, GLint y, GLint z, GLint w);
--    void uniform4iv(WebGLUniformLocation? location, Int32Array v);
--    void uniform4iv(WebGLUniformLocation? location, sequence<long> v);

   procedure Uniform_Matrix_2fv
    (Self      : in out WebGL_Rendering_Context'Class;
     Location  : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Transpose : Boolean;
     Value     : GLfloat_Matrix_2x2);

--    void uniformMatrix2fv(WebGLUniformLocation? location, GLboolean transpose,
--                          sequence<GLfloat> value);

   procedure Uniform_Matrix_3fv
    (Self      : in out WebGL_Rendering_Context'Class;
     Location  : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Transpose : Boolean;
     Value     : GLfloat_Matrix_3x3);

--    void uniformMatrix3fv(WebGLUniformLocation? location, GLboolean transpose,
--                          sequence<GLfloat> value);

   procedure Uniform_Matrix_4fv
    (Self      : in out WebGL_Rendering_Context'Class;
     Location  : Web.GL.Uniform_Locations.WebGL_Uniform_Location'Class;
     Transpose : Boolean;
     Value     : GLfloat_Matrix_4x4);

--    void uniformMatrix4fv(WebGLUniformLocation? location, GLboolean transpose,
--                          sequence<GLfloat> value);

   procedure Use_Program
    (Self    : in out WebGL_Rendering_Context'Class;
     Program : Web.GL.Programs.WebGL_Program'Class);

--   not overriding procedure Validate_Program
--    (Self    : not null access WebGL_Rendering_Context;
--     Program : access WebAPI.WebGL.Programs.WebGL_Program'Class) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "validateProgram";
--
--   not overriding procedure Vertex_Attrib_1f
--    (Self  : not null access WebGL_Rendering_Context;
--     Index : GLuint;
--     X     : GLfloat) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "vertexAttrib1f";
--
----    typedef (Float32Array or sequence<GLfloat>) VertexAttribFVSource;
----    void vertexAttrib1fv(GLuint indx, VertexAttribFVSource values);
--
--   not overriding procedure Vertex_Attrib_2f
--    (Self  : not null access WebGL_Rendering_Context;
--     Index : GLuint;
--     X     : GLfloat;
--     Y     : GLfloat) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "vertexAttrib2f";
--
--   not overriding procedure Vertex_Attrib_2fv
--    (Self  : not null access WebGL_Rendering_Context;
--     Index : GLuint;
--     Value : GLfloat_Matrix_2x2) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "vertexAttrib2fv";
--
--   not overriding procedure Vertex_Attrib_3f
--    (Self  : not null access WebGL_Rendering_Context;
--     Index : GLuint;
--     X     : GLfloat;
--     Y     : GLfloat;
--     Z     : GLfloat) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "vertexAttrib3f";
--
--   not overriding procedure Vertex_Attrib_3fv
--    (Self  : not null access WebGL_Rendering_Context;
--     Index : GLuint;
--     Value : GLfloat_Matrix_3x3) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "vertexAttrib3fv";
--
--   not overriding procedure Vertex_Attrib_4f
--    (Self  : not null access WebGL_Rendering_Context;
--     Index : GLuint;
--     X     : GLfloat;
--     Y     : GLfloat;
--     Z     : GLfloat;
--     W     : GLfloat) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "vertexAttrib4f";
--
--   not overriding procedure Vertex_Attrib_4fv
--    (Self  : not null access WebGL_Rendering_Context;
--     Index : GLuint;
--     Value : GLfloat_Matrix_4x4) is abstract
--       with Import     => True,
--            Convention => JavaScript_Method,
--            Link_Name  => "vertexAttrib4fv";

   procedure Vertex_Attrib_Pointer
    (Self       : in out WebGL_Rendering_Context'Class;
     Index      : GLuint;
     Size       : GLint;
     Data_Type  : GLenum;
     Normalized : Boolean;
     Stride     : GLsizei;
     Offset     : GLintptr);

   procedure Viewport
    (Self   : in out WebGL_Rendering_Context'Class;
     X      : GLint;
     Y      : GLint;
     Width  : GLsizei;
     Height : GLsizei);

end Web.GL.Rendering_Contexts;
