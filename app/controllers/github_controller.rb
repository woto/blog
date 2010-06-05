class GithubController < ApplicationController

  def index
      feed = Feedzirra::Feed.fetch_and_parse(AppConfig.github)
      feed.entries.each do |entry|
        p = Post.find_or_initialize_by_remote_id(entry.entry_id)
        p.category = Category.find_or_create_by_name('Github')
        p.title = entry.title
        p.body = entry.content
        p.intro = p.body
        p.date = entry.published
        p.remote_id = entry.entry_id
        tag = URI::split(entry.links[0])[5].scan(/\A\/*([^\/]+)?\/([^\/]+)/)
        p.tag_list = [tag[0], tag[1]]
        p.save
      end
  end
end
