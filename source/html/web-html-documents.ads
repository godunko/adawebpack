
with Web.DOM.Documents;
with Web.HTML.Elements;
with Web.Strings;

package Web.HTML.Documents is

   type Document is new Web.DOM.Documents.Document with null record;

   function Get_Element_By_Id
    (Self       : Document'Class;
     Element_Id : Web.Strings.Web_String)
       return Web.HTML.Elements.HTML_Element;
   --  Conventional overloading of Get_Element_By_Id.

end Web.HTML.Documents;
