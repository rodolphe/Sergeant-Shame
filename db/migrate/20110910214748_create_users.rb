class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :id
      t.integer :fb_id
      t.integer :viadeo_id
      t.string :twitter_username

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
