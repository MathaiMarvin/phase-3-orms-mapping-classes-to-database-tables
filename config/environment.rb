require 'bundler'
Bundler.require

require_relative '../lib/song'

# It is the work of the program as a whole to be able to creat and establish the database


#The DB is the constant that is equal to the hash that tends to contain our connection to the database.


DB = { conn: SQLite3::Database.new("db/music.db") }
