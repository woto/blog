class DeliciousController < ApplicationController

  def index
     d = WWW::Delicious.new('woto', 'qwer332')
     l = d.posts_all
     l.each{|i|
       p = Post.new
       p.title = i.title # DateTime.now.to_s
       p.date = i.time
       p.body = ".          "
       p.tag_list = i.tags
       p.category = Category.find_or_create_by_name("Delicious")
       #p.date = DateTime.now
       #logger.debug(p.valid?)
       debugger
       p.save
     }
     # logger.debug(YAML::dump(p.title))
  end
end
