class Song

  #The setter and getter methods for name and album 
  attr_accessor :name, :album

  #WE have a constructor that tends to create an instance of the name and the album.

  def initialize(name:, album:)
    @name = name
    @album = album
  end

end
# It is not the work of the song class to create the database.
# The classes are mapped into tables that are inside the database not the database as a whole.