class Post < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 2

  belongs_to :user
  belongs_to :category
  validates_presence_of :title, :body
  validates_length_of :body, :minimum => 9
  validates_datetime :date
  acts_as_taggable_on :tags
  named_scope :by_category, :conditions => {:category_id => 1}

  define_index do
    indexes title
    indexes body

    has tags(:id), :as => :tag_ids

    has user_id

    #where "visible = 1"
  end

end
