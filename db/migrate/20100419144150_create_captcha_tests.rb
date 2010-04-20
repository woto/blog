class CreateCaptchaTests < ActiveRecord::Migration
  def self.up
    create_table :captcha_tests do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :captcha_tests
  end
end
