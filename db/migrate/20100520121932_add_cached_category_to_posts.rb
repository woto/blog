class AddCachedCategoryToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :cached_category, :text
  end

  def self.down
    remove_column :posts, :cached_category
  end
end
