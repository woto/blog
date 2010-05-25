# Methods added to this helper will be available to all templates in the application.

module ApplicationHelper


  def categories
    cat = Category.find_by_sql('select c2.name, c2.id, count(*) as lvl from categories as c1, categories as c2 where c2.lft between c1.lft and c1.rgt group by c2.name order by c2.lft')
    out = ""
    out << '<ul class="links">'
      counter = 0
      cat.each_with_index do |c, i|

        if !cat[i+1].nil? && cat[i+1].lvl.to_i > c.lvl.to_i
          counter += 1
          out << "<li>" + link_to(c.name, search_posts_path(:date => params[:date], :tags => params[:tags], :category => c.name)) + '<ul class="links">'
        end

        if !cat[i+1].nil? && cat[i+1].lvl.to_i == c.lvl.to_i
          out << "<li>" + link_to(c.name, search_posts_path(:date => params[:date], :tags => params[:tags], :category => c.name)) + "</li>"
        end

        if !cat[i+1].nil? && cat[i+1].lvl.to_i < c.lvl.to_i
          out << "<li>" + link_to(c.name, search_posts_path(:date => params[:date], :tags => params[:tags], :category => c.name)) + "</li>"
          counter -= 1
          (c.lvl.to_i - cat[i+1].lvl.to_i).times do
              out << "</ul></li>"
          end
        end
        
        if (cat[i+1].nil?)
          out << "<li>" + link_to(c.name, search_posts_path(:date => params[:date], :tags => params[:tags], :category => c.name)) + "</li>"
          counter.times do
            out << "</ul></li>"
          end
        end
      end
    out << "</ul>"
  end

  def filters
    out = ""
    if params[:category] and category = Category.find_by_name(params[:category])
      out << "<p> Просмотр происходит внутри категории: ( "
      category.self_and_ancestors.each do |item|
        out << link_to(item.name, search_posts_path(:date => params[:date], :tags => params[:tags], :category => item.name))
        out << " → " unless category.self_and_ancestors.last == item 
      end 
      out << " ) "
      out << link_to("<sup>x</sup>", search_posts_path(:date => params[:date], :tags => params[:tags]))
      out << "</p>"
    end
    if params[:tags]
      out << "<p>"
      tags = Array.[](params[:tags]).flatten
      out << "Включен фильтр по" +  Russian.p(tags.count, "тегу", "тегам", "тегам") + ":"
      tags.each { |tag|
        out << " ( " + link_to(h(tag), search_posts_path(:date => params[:date], :tags => tag, :category => params[:category])) + " ) "
        out << link_to("<sup>x</sup>", search_posts_path(:date => params[:date], :tags => tags.reject{|item| item == tag}, :category => params[:category]))
      }
      out << "</p>"
    end
    if params[:date]
      out << "<p>Включен фильтр по дате: ( "
      if params[:date] =~ /^\d+-\d+-00$/
        out << Russian.strftime(@date, "%B %Y")
      elsif params[:date] =~ /^\d+-\d+-\d+$/
        out << Russian.strftime(@date, "%d %B %Y")
      end
      out << " ) "
      out << link_to("<sup>x</sup>", search_posts_path(:tags => params[:tags], :category => params[:category]))
      out << "</p>"
    end
    out << "<p> Внимание, при листании календаря действие всех фильтров кроме фильтра по дате сохраняется, " + link_to("вы можете сбросить все фильтры", search_posts_path) + "</a>. </p>"
    return out
  end

  def link_tags(tags)
    search_posts_path(:tags => tags, :category => params[:category], :date => params[:date])
  end
end
