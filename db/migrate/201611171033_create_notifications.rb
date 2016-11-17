class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :type_id
      t.string :content
      t.string :type
      t.date :create_time
      t.boolean :readmark
    end
  end
end
