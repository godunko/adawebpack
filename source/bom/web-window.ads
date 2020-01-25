------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2020, Vadim Godunko                                         --
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
--  Representation of 'window' object
------------------------------------------------------------------------------

with Web.HTML.Documents;

package Web.Window is

   type Frame_Request_Callback is
     access procedure (Time : Web.DOM_High_Res_Time_Stamp)
       with Convention => C;

   function Document return Web.HTML.Documents.Document;

   function Request_Animation_Frame
    (Callback : not null Frame_Request_Callback) return Web.DOM_Unsigned_Long;

   -----------------------
   -- CSSOM View Module --
   -----------------------

--  partial interface Window {
--      [NewObject] MediaQueryList matchMedia(DOMString query
--  );
--      [SameObject, Replaceable] readonly attribute Screen screen;
--
--      // browsing context
--      void moveTo(long x
--  , long y
--  );
--      void moveBy(long x
--  , long y
--  );
--      void resizeTo(long x
--  , long y
--  );
--      void resizeBy(long x
--  , long y
--  );
--
--      // viewport
--      [Replaceable] readonly attribute long innerWidth;
--      [Replaceable] readonly attribute long innerHeight;
--
--      // viewport scrolling
--      [Replaceable] readonly attribute double scrollX;
--      [Replaceable] readonly attribute double pageXOffset;
--      [Replaceable] readonly attribute double scrollY;
--      [Replaceable] readonly attribute double pageYOffset;
--      void scroll(optional ScrollToOptions options
--  );
--      void scroll(unrestricted double x
--  , unrestricted double y
--  );
--      void scrollTo(optional ScrollToOptions options
--  );
--      void scrollTo(unrestricted double x
--  , unrestricted double y
--  );
--      void scrollBy(optional ScrollToOptions options
--  );
--      void scrollBy(unrestricted double x
--  , unrestricted double y
--  );
--
--      // client
--      [Replaceable] readonly attribute long screenX;
--      [Replaceable] readonly attribute long screenY;
--      [Replaceable] readonly attribute long outerWidth;
--      [Replaceable] readonly attribute long outerHeight;

   function Get_Device_Pixel_Ratio return Web.DOM_Double;

end Web.Window;
