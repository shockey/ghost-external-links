window.jQuery || document.write("<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'>\x3C/script>") || console.warn("Ghost External Links was unable to detect or add jQuery to the page.");

$(document).ready(function() {
   $("a[href^=http]").each(function(){
      var excluded = [
         // format for whitelist: 'google.com', 'apple.com', 'myawesomeblog.com'
         // add your excluded domains here
         ];
      for(i=0; i<excluded.length; i++) {
         if(this.href.indexOf(excluded[i]) != -1) {
            return true;
         }
      }
      if(this.href.indexOf(location.hostname) == -1) {
           $(this).click(function() { return true; }); 
           $(this).attr({
               target: "_blank",
               title: "Opens in a new window"
           });
           $(this).click();
      }
   })
});
