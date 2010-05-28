ActionView::Base.class_eval do 
  # Returns an HTML-formatted version of the given nested set instance (or array of instances).  The default
  # is to create a nested tree via an HTML Unordered List, using the passed in block as the contents for each
  # <li> tag.
  def format_nested_set(item_or_items, options = {}, &block)
    options.reverse_merge!({
      :major => {:tag => :ul, :class => 'tree'},
      :minor => {:tag => :li, :class => nil}
    })
    
    item_or_items = Array(item_or_items)
    
    content = ''
    return content if item_or_items.empty?
    
    item_or_items.each do |i|
      minor_content = yield(i) + format_nested_set(i.children, options, &block)
      content << if options[:minor][:tag]
        content_tag(options[:minor][:tag], minor_content, :class => options[:minor][:class])
      else
        minor_content
      end
    end
    
    if options[:major][:tag]
      content_tag(options[:major][:tag], content, :class => options[:major][:class])
    else
      content
    end
  end
end
