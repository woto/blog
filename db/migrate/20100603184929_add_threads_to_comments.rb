class AddThreadsToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :parent_id, :integer
    add_column :comments, :lft, :integer
    add_column :comments, :rgt, :integer
  end

  def self.down
    remove_column :comments, :parent_id
    remove_column :comments, :lft
    remove_column :comments, :rgt
  end
end
