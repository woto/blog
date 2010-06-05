class VimeoController < ApplicationController
  
  require 'open-uri'
  require 'nokogiri'
  require 'feedzirra'

  def index
   feed = Feedzirra::Feed.fetch_and_parse(AppConfig.vimeo)
    feed.entries.each do |entry|
      #p = Post.new
      p = Post.find_or_initialize_by_remote_id(entry.entry_id)
      p.category = Category.find_or_create_by_name("Vimeo")
      p.title = entry.title
      p.date = entry.published
      p.body = entry.summary
      p.body = p.body.to_s + "<p><a href='#{entry.url.to_s}'>#{entry.url.to_s}</a></p>"
      p.intro = p.body
      #p.tag_list = entry.categories
      p.save
    end
  end

end
