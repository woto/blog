# Methods added to this helper will be available to all templates in the application.

module ApplicationHelper
  def post_category(post)
    out = ""
    if post.cached_category
      out << "в категории "
      out << post.cached_category.map{|item| link_to(item.name, link_category(item.name, false), :rel => link_category(item.name, true))}.join(' → ')
    #else
    #  out << "без категории "
    end
  end

  def categories
    out = ""
    cat = Category.find_by_sql('select c2.name, c2.id, count(*) as lvl from categories as c1, categories as c2 where c2.lft between c1.lft and c1.rgt group by c2.name order by c2.lft')
    out << "<div class='box'>"
    out << '<ul class="links">'
      counter = 0
      cat.each_with_index do |c, i|

        if !cat[i+1].nil? && cat[i+1].lvl.to_i > c.lvl.to_i
          counter += 1
          out << "<li>" + link_to(c.name, link_category(c.name, false), :rel => link_category(c.name, true)) + '<ul class="links">'
        end

        if !cat[i+1].nil? && cat[i+1].lvl.to_i == c.lvl.to_i
          out << "<li>" + link_to(c.name, link_category(c.name, false), :rel => link_category(c.name, true))  + "</li>"
        end

        if !cat[i+1].nil? && cat[i+1].lvl.to_i < c.lvl.to_i
          out << "<li>" + link_to(c.name, link_category(c.name, false), :rel => link_category(c.name, true)) + "</li>"
          counter -= 1
          (c.lvl.to_i - cat[i+1].lvl.to_i).times do
              out << "</ul></li>"
          end
        end
        
        if (cat[i+1].nil?)
          out << "<li>" + link_to(c.name, link_category(c.name, false), :rel => link_category(c.name, true)) + "</li>"
          counter.times do
            out << "</ul></li>"
          end
        end
      end
    out << "</ul>"
    out << "</div>"
  end

  def filters
    if params[:category] || params[:tags] || params[:date]
      out = ""
      out << "<div class='box' style='position: relative'>"
      out << "<div style='position: absolute; top: 0px; right: 6px'>" + link_to("x", posts_path) + "</div>"
      if params[:category] and category = Category.find_by_name(params[:category])
          out << "<div>"
          out << link_to("-", search_posts_path(:date => params[:date], :tags => params[:tags]))
          out << " Просмотр происходит внутри категории: "
          category.self_and_ancestors.each do |item|
            out << link_to(item.name, link_category(item.name, false), :rel => link_category(item.name, true))
            out << " → " unless category.self_and_ancestors.last == item 
          end 
          out << "</div>"
      end
      if params[:tags]
        out << "<div>"
        tags = Array.[](params[:tags]).flatten
        out << link_to("-", search_posts_path(:date => params[:date], :category => params[:category]))
        out << " Включен фильтр по " +  Russian.p(tags.count, "тегу", "тегам", "тегам") + ": "
        tags.each { |tag|
          out << link_to("-", search_posts_path(:date => params[:date], :tags => tags.reject{|item| item == tag}, :category => params[:category]))
          out << "&nbsp;"
          out << link_to(h(tag), search_posts_path(:tags => tag))
          out << ", " unless tag == tags.last
        }
        out << "</div>"
      end
      if params[:date]
        out << "<div>"
        out << link_to("-", search_posts_path(:tags => params[:tags], :category => params[:category]))
        out << " Включен фильтр по дате: "
        out << "<a href='"
        out << url_for(search_posts_path(:date => params[:date]))
        out << "'>"
        if params[:date] =~ /^\d+-\d+-00$/
          out << Russian.strftime(@date, "%B %Y")
        elsif params[:date] =~ /^\d+-\d+-\d+$/
          out << Russian.strftime(@date, "%d %B %Y")
        end
        out << "</a>"
        out << "</div>"
      end
      out << "</div>"
    end
  end

  def link_tags(tags, save_state)
    if save_state
      search_posts_path(:tags => tags, :category => params[:category], :date => params[:date])
    else
      search_posts_path(:tags => tags)
    end
  end

  def link_category(category, save_state)
    if save_state
      search_posts_path(:tags => params[:tags], :category => category, :date => params[:date])
    else
      search_posts_path(:category => category)
    end
  end

  def link_calendar(date, save_state)
    if save_state
      search_posts_path(:tags => params[:tags], :category => params[:category], :date => date)
    else
      search_posts_path(:date => date)
    end
  end
end
