class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  belongs_to :user
  acts_as_nested_set
  # определение для более быстрого построения дерева одним запросом
  def lvl
    attributes['lvl']
  end
end
