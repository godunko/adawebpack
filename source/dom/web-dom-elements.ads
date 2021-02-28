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

with Web.DOM.Nodes;
with Web.DOM.Token_Lists;
with Web.Strings;

package Web.DOM.Elements is

   pragma Preelaborate;

   type Element is new Web.DOM.Nodes.Node with null record;

   --  interface Element : Node {
   --    readonly attribute DOMString? namespaceURI;
   --    readonly attribute DOMString? prefix;
   --    readonly attribute DOMString localName;
   --    readonly attribute DOMString tagName;
   --
   --    [CEReactions] attribute DOMString className;
   --    [CEReactions, Unscopable] attribute DOMString slot;
   --
   --    boolean hasAttributes();
   --    [SameObject] readonly attribute NamedNodeMap attributes;
   --    sequence<DOMString> getAttributeNames();
   --    DOMString? getAttribute(DOMString qualifiedName);
   --    DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
   --    [CEReactions] void setAttribute(DOMString qualifiedName, DOMString value);
   --    [CEReactions] void setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
   --    [CEReactions] void removeAttribute(DOMString qualifiedName);
   --    [CEReactions] void removeAttributeNS(DOMString? namespace, DOMString localName);
   --    [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
   --    boolean hasAttribute(DOMString qualifiedName);
   --    boolean hasAttributeNS(DOMString? namespace, DOMString localName);
   --
   --    Attr? getAttributeNode(DOMString qualifiedName);
   --    Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
   --    [CEReactions] Attr? setAttributeNode(Attr attr);
   --    [CEReactions] Attr? setAttributeNodeNS(Attr attr);
   --    [CEReactions] Attr removeAttributeNode(Attr attr);
   --
   --    ShadowRoot attachShadow(ShadowRootInit init);
   --    readonly attribute ShadowRoot? shadowRoot;
   --
   --    Element? closest(DOMString selectors);
   --    boolean matches(DOMString selectors);
   --    boolean webkitMatchesSelector(DOMString selectors); // historical alias of .matches
   --
   --    HTMLCollection getElementsByTagName(DOMString qualifiedName);
   --    HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
   --    HTMLCollection getElementsByClassName(DOMString classNames);
   --
   --    [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // historical
   --    void insertAdjacentText(DOMString where, DOMString data); // historical
   --  };

   function Get_Id (Self : Element'Class) return Web.Strings.Web_String;
   --  Returns the value of element’s id content attribute. Can be set to
   --  change it.

   procedure Set_Id
    (Self : in out Element'Class;
     To   : Web.Strings.Web_String);
   --  Returns the value of element’s id content attribute. Can be set to
   --  change it.

   function Get_Class_List
    (Self : Element'Class) return Web.DOM.Token_Lists.DOM_Token_List;
   --  Allows for manipulation of element’s class content attribute as a set
   --  of whitespace-separated tokens through a DOMTokenList object.

   -----------------------
   -- CSSOM View Module --
   -----------------------

--  partial interface Element {
--    sequence<DOMRect> getClientRects();
--    [NewObject] DOMRect getBoundingClientRect();
--    void scrollIntoView();
--    void scrollIntoView((boolean or object) arg
--  );
--    void scroll(optional ScrollToOptions options
--  );
--    void scroll(unrestricted double x
--  , unrestricted double y
--  );
--    void scrollTo(optional ScrollToOptions options
--  );
--    void scrollTo(unrestricted double x
--  , unrestricted double y
--  );
--    void scrollBy(optional ScrollToOptions options
--  );
--    void scrollBy(unrestricted double x
--  , unrestricted double y
--  );
--    attribute unrestricted double scrollTop;
--    attribute unrestricted double scrollLeft;
--    readonly attribute long scrollWidth;
--    readonly attribute long scrollHeight;
--    readonly attribute long clientTop;
--    readonly attribute long clientLeft;

   function Get_Client_Height (Self : Element'Class) return Web.DOM_Long;

   function Get_Client_Width (Self : Element'Class) return Web.DOM_Long;

end Web.DOM.Elements;
