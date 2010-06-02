class GithubController < ApplicationController

  def index
      feed = Feedzirra::Feed.fetch_and_parse("http://github.com/woto.atom")
      feed.entries.each do |entry|
        p = Post.new
        p.category = Category.find_or_create_by_name('Github')
        p.title = entry.title
        p.body = entry.content
        p.date = entry.published
        if entry.links.count > 1
          debugger
        end
        tag = URI::split(entry.links[0])[5].scan(/\A\/*(\w+)?\/(\w+)/)
        p.tag_list = [tag[0], tag[1]]
        p.save
      end
  end
end
