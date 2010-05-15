class GithubController < ApplicationController

  def index
      #user = Octopi::User.find("fcoury")

      #repo = Octopi::Repository.find(:user => "woto")
      #puts repo
      feed = Feedzirra::Feed.fetch_and_parse("http://github.com/woto.atom")
      feed.entries.each do |entry|
        p = Post.new
        p.category = Category.find_or_create_by_name('Github')
        p.title = entry.title
        p.body = entry.content
        p.date = entry.published
        p.tag_list = entry.links
        p.save
      end
  end

end
