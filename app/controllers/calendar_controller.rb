class CalendarController < ApplicationController

  def index
    @calendar_posts = CalendarPosts::get_calendar_posts params, @date, false
    respond_to do |format|
      format.js {render :action => "calendar.rjs", :object => @calendar_posts}
    end
  end

end
