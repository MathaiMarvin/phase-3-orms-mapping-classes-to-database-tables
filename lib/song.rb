class Song

  #The setter and getter methods for name and album 
  attr_accessor :name, :album, :id

  #WE have a constructor that tends to create an instance of the name and the album.

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  # Based on the ORM convention a class must be mapped to a database table and therefore we need to create the songs table.
  # The class method will create the table.


        # NOTE TO BE ABLE TO MAP OUR CLASS TO OUR DATABASE TABLE, WE TEND TO CREATE A TABLE WITH THE SAME NAME AS OUR CLASS AND GIVE THE COLUMN NAMES OF OUR TABLE THE SAME AS THE attr_accessor class.
  
        #The class methodis used because it is not the responsibility of an individual song to create the table but rather the class as a whole.
        def self.create_table

          query = <<-SQL

          CREATE TABLE IF NOT EXISTS songs (
            id INTEGER PRIMARY KEY,
            name TEXT,
            album TEXT
          )
          SQL

          DB[:conn].execute(query)
        end

        # Everytime we need to save the attributes of any song in the db we use an instance method save


        # The save method inserts a record into our database that has both the name and album values of the song instance that we are attempting to save.
        # The sqlite3 gem takes in the values that we pass as an argument and applies them as the values of thequestion mark.
        def save
          query = <<-SQL
          INSERT INTO songs(name, album)
          VALUES(?, ?)
          SQL

          DB[:conn].execute(query, self.name, self.album)

          # Getting a song if from the database and saving it the Ruby instance
          self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

          #Return the ruby instance
          self
        end

        # WE can create a song instance and save it
        def self.create(name:, album:)
          song = Song.new(name: name, album: album)
          song.save
        end

        # In the code block above we are not saving the ruby object but rather creating a new row in the table that has the values that characterize the song instance.
end
# It is not the work of the song class to create the database.
# The classes are mapped into tables that are inside the database not the database as a whole.


# It is worth noting that the moment in which we create a new song instance through the initialize method is different than the moment that we decide to save the representation of the song to our db. 
# Initialize creates a new instance of the song class which is a Ruby object.
# The save method then takes the attributes that tend to characterize a song and then saves them in a new row of songs table in our database.