class CalendarController < ApplicationController

  def index
    if(params[:ignore_filters])
      @calendar = CalendarPosts::get_calendar_posts({}, @date)
    else
      @calendar = CalendarPosts::get_calendar_posts(params, @date)
    end

    render :update do |page|
      page.replace_html :calendar, render(:partial => 'index', :object => @calendar_posts, :locals => {:ignore_filters => params[:ignore_filters]})
    end
  end

end
