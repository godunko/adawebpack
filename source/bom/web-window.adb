
with WASM.Objects;

package body Web.Window is

   --------------
   -- Document --
   --------------

   function Document return Web.HTML.Documents.Document is
      function Internal return WASM.Objects.Object_Identifier
        with Import     => True,
             Convention => C,
             Link_Name  => "__adawebpack__bom__window__document";

   begin
      return Web.HTML.Documents.Instantiate (Internal);
   end Document;

end Web.Window;
