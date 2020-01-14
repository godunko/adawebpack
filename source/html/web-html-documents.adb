
with Web.DOM.Elements;

package body Web.HTML.Documents is

   -----------------------
   -- Get_Element_By_Id --
   -----------------------

   function Get_Element_By_Id
    (Self       : Document'Class;
     Element_Id : Web.Strings.Web_String)
       return Web.HTML.Elements.HTML_Element is
   begin
      return
        Web.HTML.Elements.Instantiate
         (Web.DOM.Elements.Element'
           (Self.Get_Element_By_Id (Element_Id)).Identifier);
   end Get_Element_By_Id;

end Web.HTML.Documents;
