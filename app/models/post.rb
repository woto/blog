class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates_presence_of :title, :body
  validates_length_of :body, :minimum => 9
  validates_datetime :date
  acts_as_taggable_on :tags
end
