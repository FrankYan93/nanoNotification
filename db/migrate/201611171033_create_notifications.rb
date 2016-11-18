class CreateNotifications < ActiveRecord::Migration
    def change
        create_table :notifications do |t|
            t.integer :user_id
            t.integer :owner_id
            t.integer :tweet_id
            t.string :content
            t.string :notitype
            t.date :create_time
            t.boolean :readmark
            t.index :owner_id
        end
    end
end
