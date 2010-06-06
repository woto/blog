module CalendarPosts

  def self.get_calendar_posts params, date
    scope = Post

    if params[:category]
      scope = scope.with_category_ids(Category.find_by_name(params[:category]).self_and_descendants)
    end
    
    scope = scope.within_month(date)

    if params[:tags]
      scope = scope.tagged_with(Array.[](params[:tags]).flatten.join(','), :on => :tags)
    end

    scope.find(:all, :order => 'date DESC')

  end
end
