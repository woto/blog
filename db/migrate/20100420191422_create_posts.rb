class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :intro
      t.text :body
      t.boolean :visible
      t.datetime :date
      t.references :user
      t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
