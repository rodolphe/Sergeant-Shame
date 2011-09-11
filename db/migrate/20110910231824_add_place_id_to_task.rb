class AddPlaceIdToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :place_id, :integer
  end

  def self.down
    remove_column :tasks, :place_id
  end
end
