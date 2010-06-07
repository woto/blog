class Post < ActiveRecord::Base

  before_save :invalidate_cached_category, :if => :category

  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  
  # не проверяем уникальность заголовка, 
  # has_friendly_id корректно обрабатывает
  # validates_uniqueness_of :title

  cattr_reader :per_page
  @@per_page = 10

  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :category

  has_many :comments
  #accepts_nested_attributes_for :comments

  validates_presence_of :title, :body
  # из-за бага в ckeditor'e firefox даже при условии
  # что текст не вводили забивает его небольшим мусором
  validates_length_of :body, :minimum => 9
  # todo отказался в пользу delocalize
  #validates_datetime :date
  acts_as_taggable_on :tags

  serialize :cached_category
 
  def invalidate_cached_category
    # todo необходимо сохранить категорию прежде чем мы 
    # получим полный путь к категории
    category.save!
    self.cached_category = category.self_and_ancestors
  end

  def self.get_cat_ids_tree_by_name(category_name)
    raise "Obsolete model method"
    # obsolete
  end

  named_scope :with_category_ids, lambda{|category_ids|
    {:conditions => ["posts.category_id IN (?)", category_ids]}
  }

  named_scope :within_month, lambda{|month|
    {:conditions => ["posts.date > ? AND posts.date < ?", month.beginning_of_month, month.end_of_month]}
  }

  # todo Проверить new_offset
  named_scope :within_day, lambda {|day|
    {:conditions => ["posts.date > ? AND posts.date < ?", day.beginning_of_day.new_offset, day.end_of_day.new_offset ]}
  }

  define_index do
    indexes title
    indexed intro
    indexes body
    #indexes :date, :sortable => true
    indexes comments.body

    has tags(:id), :as => :tag_ids
    has :category_id
    has :date
    has created_at

    # Поиск по тегам и категориям отключен принципиально
    #indexes cached_tag_list
    #
    #has tags(:id), :as => :tag_ids
    #has user_id
    #has comments(:body)
    #indexes :comment
    #where "visible = 1"
  end

end
