
with Web.DOM.Elements;
with Web.DOM.Nodes;
with Web.DOM.Non_Element_Parent_Nodes;

package Web.DOM.Documents is

   pragma Preelaborate;

   type Document is
     new Web.DOM.Nodes.Node
       and Web.DOM.Non_Element_Parent_Nodes.Non_Element_Parent_Node
         with null record;

   overriding function Get_Element_By_Id
    (Self       : Document;
     Element_Id : Wide_String) return Web.DOM.Elements.Element;

end Web.DOM.Documents;
