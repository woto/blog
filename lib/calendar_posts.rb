module CalendarPosts

  def self.get_calendar_posts params, date, current_month
    scope = Post

    if params[:category]
      scope = scope.with_category_ids(Post.get_cat_ids_tree_by_name(params[:category]))
    end
    
    # Если был аякс запрос, то приходит (params, @date, true)
    # т.е берем нужный месяц и показываем по нему посты, с учетом остальных фильтров
    # Если стандартный партиал, то всегда получаем в рамках месяца, (params, @date, false)
    # т.е. берем посты только за месяц с учетом нужных фильтров
    if params[:date] || !current_month
      scope = scope.within_month(date)
    end

    if params[:tags]
      scope = scope.tagged_with(Array.[](params[:tags]).flatten.join(','), :on => :tags)
    end

    scope.find(:all, :order => 'date DESC')

  end
end
