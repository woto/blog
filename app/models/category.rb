class Category < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  acts_as_nested_set

  has_many :posts, :dependent => :destroy

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

  # Необходимо обновить post.cached_category при перемещении категории
  # сохраняем без обратного вызова, т.к. при сохранении поста у нас уже есть
  # обратный вызов, тем самым избегаем зацикливания
  after_save do |category|
    category.posts.each do |post|
      post.cached_category = category.self_and_ancestors
      post.send(:update_without_callbacks)
    end
  end

  #after_save :invalidate_full_tree_cache
  #after_destroy :invalidate_full_tree_cache

  #def path_name
  #  "#{'-' * self.level} #{self.name}"
  #end

end
