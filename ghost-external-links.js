$(document).ready(function() {
   $("a[href^=http]").each(function(){
      var excluded = [
         // add your excluded domains here, like this: 'google.com', 'apple.com', 'myawesomeblog.com'
         ];
      for(i=0; i<excludes.length; i++) {
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