var refresh_links = function(selector){

  selector.find('a').each(function(i, e){
    $(e).click(function(event){
      if($.cookie(window.COOKIE_NAME) == '1' &&
        ($(this).attr('rel') && 
        $(this).attr('rel').match(/\/.*/i)))
      {
        if($(this).attr('href') == $(this).attr('rel')) return;
        event.preventDefault();
        //window.location.replace($(this).attr('rel'));
        toolbox = $("<div id='tooltip' class='box'></div>");
        toolbox.css("position", "absolute");
        toolbox.css("top", $(this).position().top - 13);
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

    advanced_on = 'Выключить сложную навигацию'
    advanced_off = 'Включить сложную навигацию'

    if($.cookie(window.COOKIE_NAME) == "1")
    {
      $('#advanced_navigation').next().html(advanced_on);
      $('#advanced_navigation').attr('checked', true);
      $("#make_search_advanced").show();
      $("#make_search_advanced").appendTo($("#search form"))
    }
    else
    {
      $('#advanced_navigation').next().html(advanced_off);
      $('#advanced_navigation').attr('checked', "");
      $("#make_search_advanced").hide();
      $("#make_search_advanced").appendTo($("#search"))
    }

    $("#advanced_navigation").click(function(){
      if($(this).is(":checked"))
      {
        $(this).next().html(advanced_on);
        $.cookie(window.COOKIE_NAME, "1", options);
        $("#make_search_advanced").show();
        $("#make_search_advanced").appendTo($("#search form"))
      }
      else
      {
        $(this).next().html(advanced_off);
        $.cookie(window.COOKIE_NAME, "0", options);
        $("#make_search_advanced").hide();
        $("#make_search_advanced").appendTo($("#search"))
      }
    });


    refresh_links($(document));

    // $(".post").not('.remote').mouseover(function(){
    $(".post").mouseover(function(){
      $(this).find('.control').show();
    })

    //$(".post").not('.remote').mouseout(function(){
    $(".post").mouseout(function(){
      $(this).find('.control').hide();
    })

    $(".scroll_to_filter").click(function(e){
      e.preventDefault();
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
