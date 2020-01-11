
with Web.DOM.Elements;
with Web.Strings;

package Web.DOM.Non_Element_Parent_Nodes is

   pragma Preelaborate;

   type Non_Element_Parent_Node is limited interface;

   not overriding function Get_Element_By_Id
    (Self       : Non_Element_Parent_Node;
     Element_Id : Web.Strings.Web_String)
       return Web.DOM.Elements.Element is abstract;
   --  Returns the first element within node's descendants whose ID is
   --  Element_Id.

end Web.DOM.Non_Element_Parent_Nodes;
