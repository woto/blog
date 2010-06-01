class Category < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  acts_as_nested_set

  has_many :posts#, :dependent => :nullify

  # определение для более быстрого построения дерева одним запросом
  def lvl
    attributes['lvl']
  end

  before_destroy do |category|
    posts = []
    Post.find(:all, :conditions => ["category_id = ?", category.id]).each do |post|
      posts << post.id
    end
    Post.update_all("cached_category = NULL, category_id = NULL", ["id IN(?)", posts.join(',')])
  end

  #after_save :invalidate_full_tree_cache
  #after_destroy :invalidate_full_tree_cache

  #def path_name
  #  "#{'-' * self.level} #{self.name}"
  #end

end
