var refresh_links = function(selector){

  selector.find('a').each(function(i, e){
    $(e).click(function(event){
      if($.cookie(window.COOKIE_NAME) &&
        ($(this).attr('rel') && 
        $(this).attr('rel').match(/\/.*/i)))
      {
        if($(this).attr('href') == $(this).attr('rel')) return;
        event.preventDefault();
        //window.location.replace($(this).attr('rel'));
        toolbox = $("<div id='tooltip' class='box'></div>");
        toolbox.css("position", "absolute");
        toolbox.css("top", $(this).position().top - 13);
        //toolbox.css("background", "#EEEEEE");
        //toolbox.css("padding", "4px");
        toolbox.html( 
          "<a href='" + $(this).attr('href') + "'>" + "Без фильтра" + "</a>" +
          "<br />" +
          "<a href='" + $(this).attr('rel') + "'>" + "С фильтром" + "</a>");
        $(this).after(toolbox);
        
        toolbox.css("left", $(this).position().left + $(this).width()/2 - toolbox.width()/2);
        
        toolbox.mouseleave(function(){
          $(this).remove();
          $(this).unbind('mouseleave')
        });
      }
    });
  });
}

$(document).ready(function(){

    window.COOKIE_NAME = 'advanced_navigation';
    window.options = { path: '/', expires: new Date().getTime() + (1 * 365 * 24 * 60 * 60 * 1000) };

    $("#advanced_navigation").change(function()
    { 
        if($(this).is(":checked"))
          $.cookie(window.COOKIE_NAME, true, options);
        else
          $.cookie(window.COOKIE_NAME, "", options);
    });

    $('#advanced_navigation').attr('checked', $.cookie(window.COOKIE_NAME));

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
      // todo сделать в зависимости от браузера, а то опера иначе себя ведет 
      $('html,body').animate({scrollTop: targetOffset}, 1000, function(){
        fukc++;
        if(fukc == 2)
          $('#filter').effect("highlight", {}, 1000);
      });
    })
});
