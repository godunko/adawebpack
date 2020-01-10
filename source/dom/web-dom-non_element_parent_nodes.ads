
with Web.DOM.Elements;

package Web.DOM.Non_Element_Parent_Nodes is

   pragma Preelaborate;

   type Non_Element_Parent_Node is limited interface;

   not overriding function Get_Element_By_Id
    (Self       : Non_Element_Parent_Node;
     Element_Id : Wide_String) return Web.DOM.Elements.Element is abstract;
   --  Returns the first element within node's descendants whose ID is
   --  Element_Id.

end Web.DOM.Non_Element_Parent_Nodes;
