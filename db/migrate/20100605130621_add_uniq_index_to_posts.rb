class AddUniqIndexToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :remote_id, :string, :default => nil
    add_index :posts, :remote_id, :unique => true
  end

  def self.down
    remove_column :posts, :remote_id
  end
end
