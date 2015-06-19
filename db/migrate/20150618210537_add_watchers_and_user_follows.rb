class AddWatchersAndUserFollows < ActiveRecord::Migration
  def change

    create_table :watchers do |t|
      t.integer :user_id, null: false
      t.timestamps
    end

    create_table :user_follows do |t|
      t.integer :watcher_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end

  end
end
