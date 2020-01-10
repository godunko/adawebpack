
with Web.DOM.Documents;
with Web.HTML.Elements;

package Web.HTML.Documents is

   type Document is new Web.DOM.Documents.Document with null record;

   function Get_Element_By_Id
    (Self       : Document'Class;
     Element_Id : Wide_String) return Web.HTML.Elements.HTML_Element;
   --  Conventional overloading of Get_Element_By_Id.

end Web.HTML.Documents;
