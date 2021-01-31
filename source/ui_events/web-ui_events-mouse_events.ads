------------------------------------------------------------------------------
--                                                                          --
--                                AdaWebPack                                --
--                                                                          --
------------------------------------------------------------------------------
--  Copyright © 2020-2021, Vadim Godunko                                    --
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

with Web.UI_Events.UI_Events;

package Web.UI_Events.Mouse_Events is

   pragma Preelaborate;

   type Mouse_Event is new Web.UI_Events.UI_Events.UI_Event with null record;

--  interface MouseEvent : UIEvent {
--    constructor(DOMString type, optional MouseEventInit eventInitDict);
--    readonly attribute long screenX;
--    readonly attribute long screenY;
--    readonly attribute long clientX;
--    readonly attribute long clientY;
--
--    readonly attribute boolean ctrlKey;
--    readonly attribute boolean shiftKey;
--    readonly attribute boolean altKey;
--    readonly attribute boolean metaKey;
--
--    readonly attribute short button;
--
--    readonly attribute EventTarget? relatedTarget;
--
--    boolean getModifierState(DOMString keyArg);
--  };

   function Buttons (Self : Mouse_Event) return DOM_Unsigned_Short;

   -----------------------
   -- CSSOM View Module --
   -----------------------

--  partial interface MouseEvent {
--    readonly attribute double screenX;
--    readonly attribute double screenY;
--    readonly attribute double clientX;
--    readonly attribute double clientY;
--    readonly attribute double x;
--    readonly attribute double y;
--  };

   function Page_X (Self : Mouse_Event) return DOM_Double;

   function Page_Y (Self : Mouse_Event) return DOM_Double;

   function Offset_X (Self : Mouse_Event) return DOM_Double;

   function Offset_Y (Self : Mouse_Event) return DOM_Double;

end Web.UI_Events.Mouse_Events;
