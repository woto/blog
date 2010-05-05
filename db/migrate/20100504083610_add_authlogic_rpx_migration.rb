class AddAuthlogicRpxMigration < ActiveRecord::Migration
  def self.up
    create_table :rpx_identifiers do |t|
      t.string  :identifier, :null => false
      t.string  :provider_name
      t.integer :user_id, :null => false
      t.timestamps
    end
    add_index :rpx_identifiers, :identifier, :unique => true, :null => false
    add_index :rpx_identifiers, :user_id, :unique => false, :null => false
    
    change_column :users, :crypted_password, :string, :default => nil, :null => true
    change_column :users, :password_salt, :string, :default => nil, :null => true
    change_column :users, :email, :string, :defaul => nil, :null => true

  end
  
  def self.down
    drop_table :rpx_identifiers
    
    # == Customisation may be required here ==
    # Restore user model database constraints as appropriate
    # e.g.:
    #[:crypted_password, :password_salt].each do |field|
    #  User.all(:conditions => "#{field} is NULL").each { |user| user.update_attribute(field, "") if user.send(field).nil? }
    #  change_column :users, field, :string, :default => "", :null => false
    #end

  end
end
