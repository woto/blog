var refresh_links = function(selector){
  selector.find('a').each(function(i, e){
    $(e).click(function(event){
      if($(this).attr('rel') && $(this).attr('rel').match(/\/.*/i)) {
        if($(this).attr('href') == $(this).attr('rel')) return;
        event.preventDefault();
        toolbox = $("<div class='box'></div>");
        toolbox.css("position", "absolute");
        toolbox.css("top", $(this).position().top - 13);
        toolbox.css("background", "#EEEEEE");
        toolbox.css("padding", "4px");
        toolbox.html( 
          "<a href='" + $(this).attr('href') + "'>" + "Без фильтра" + "</a>" +
          "<br />" +
          "<a href='" + $(this).attr('rel') + "'>" + "С фильтром" + "</a>");
        $(this).after(toolbox);

        toolbox.css("left", $(this).position().left + $(this).width()/2 - toolbox.width()/2);

        toolbox.mouseleave(function(){
          $(this).remove();
        });
      }
    });
  });
}

$(document).ready(function(){
    refresh_links($(document));
    $(".post").mouseover(function(){
      $(this).find('.control').show();
    })
    $(".post").mouseout(function(){
      $(this).find('.control').hide();
    })

    $(".scroll_to_filter").click(function(){
      // уловка для Firefox и Google Chrome
      var fukc = 0
      var targetOffset = 0;
      $('html,body').animate({scrollTop: targetOffset}, 1000, function(){
        fukc++;
        if(fukc == 2)
          $('#filter').effect("highlight", {}, 1000);
      });
    })
});
