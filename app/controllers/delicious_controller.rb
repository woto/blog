class DeliciousController < ApplicationController

  def index
     d = WWW::Delicious.new(AppConfig.delicious['login'], AppConfig.delicious['password'])
     l = d.posts_recent
     l.each{|i|
       #p = Post.new
       p = Post.find_or_initialize_by_remote_id(i.uid)
       p.title = i.title # DateTime.now.to_s
       p.intro = "<p><a href='#{i.url.to_s}'><img style='border: 1px solid black' alt='#{i.url.to_s}' src='http://images.websnapr.com/?size=size&key=YL9563thKaIT&url=#{URI::encode(i.url.to_s)}'></img></a></p><p>#{i.notes.to_s}</p><p><a href='#{i.url.to_s}'>#{i.url.to_s}</a></p>"
       p.date = i.time
       p.body = p.intro
       p.tag_list = i.tags
       p.category = Category.find_or_create_by_name("Delicious")
       #p.date = DateTime.now
       #logger.debug(p.valid?)
       p.save
     }
     # logger.debug(YAML::dump(p.title))
  end
end
