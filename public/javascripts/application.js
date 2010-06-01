var refresh_links = function(selector){

  selector.find('a').each(function(i, e){
    $(e).mouseenter(function(){
      if($(this).attr('rel') && $(this).attr('rel').match(/\/.*/i)) {
        if($(this).attr('href') == $(this).attr('rel')) return;
        toolbox = $("<div class='box'></div>");
        toolbox.css("position", "absolute");
        toolbox.css("top", $(this).position().top - 13);
        toolbox.css("background", "#EEEEEE");
        toolbox.css("padding", "4px");
        toolbox.html( 
          "<a href='" + $(this).attr('href') + "'>" + "Без фильтра" + "</a>" +
          "<br />" +
          "<a href='" + $(this).attr('rel') + "'>" + "С фильтром" + "</a>");
        $(this).append(toolbox);

        if($(this).position().left + toolbox.width() > $('#wrapper').width())
          toolbox.css("left", $("#wrapper").width() - toolbox.width());
        else
          toolbox.css("left", $(this).position().left);

        toolbox.mouseleave(function(){
          $(this).remove();
        });
        $(this).mouseleave(function(){
          toolbox.remove();
        });
      }
    });
  });
}

$(document).ready(function(){
    refresh_links($(document));
});
