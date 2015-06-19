require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc 'Adds some sample data to the database'
task "db:populate" do
  # Users
  john = User.create(username: 'john', password: '123')
  bob = User.create(username: 'bob', password: '456')
  voldemort = User.create(username: 'voldemort', password: 'avadacadavra')
  # Notes
  bob.notes.create(text: "I'm bob. Sup.")
  voldys_note = voldemort.notes.create(text: "I AM VOLDEMORT! MWAAAAH!")
  voldys_other_note = voldemort.notes.create(text: "Still... VOLDEMORT!")
  # Comments
  voldys_note.comments.create(user_id: bob.id, text: "Hi voldemort! Nice to meet you. Mwaaaah.", vote_kind: 'like')
  voldys_note.comments.create(user_id: voldemort.id, text: "Hi bob. I just like doing that.")
  voldys_note.comments.create(user_id: john.id, text: "You guys are weird. Especially you, voldy.", vote_kind: 'wtf')
  # User Follows
  john.follow_user(voldemort.id)
  bob.follow_user(voldemort.id)
  bob.follow_user(john.id)
  voldemort.follow_user(bob.id)
end


