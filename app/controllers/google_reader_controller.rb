class GoogleReaderController < ApplicationController
  
  require 'open-uri'
  require 'nokogiri'
  require 'feedzirra'

  def index
   feed = Feedzirra::Feed.fetch_and_parse("http://www.google.com/reader/public/atom/user/03958211105266633351/state/com.google/broadcast")
 
    feed.entries.each do |entry|
      p = Post.new
      p.category = Category.find_or_create_by_name("Google Reader")
      p.title = entry.title
      p.date = entry.published
      p.body = entry.summary
      p.tag_list = entry.categories
      p.save
    end
  end

end
