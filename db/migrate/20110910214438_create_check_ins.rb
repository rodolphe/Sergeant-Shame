class CreateCheckIns < ActiveRecord::Migration
  def self.up
    create_table :check_ins do |t|
      t.integer :task_id

      t.timestamps
    end
  end

  def self.down
    drop_table :check_ins
  end
end
