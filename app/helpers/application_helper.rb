# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_tags(tags)
    search_posts_path(:tags => tags, :category => params[:category], :date => params[:date])
  end
end
