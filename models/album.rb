require_relative('../db/sql_runner')

class Album

  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "
    INSERT INTO albums (title, genre, artist_id)
    VALUES ($1, $2, $3)
    RETURNING id
    "
    values = [@title, @genre, @artist_id]
    result  = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def Album.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def Album.all
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album) }
  end

  def  artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values =[@artist_id]
    result = SqlRunner.run(sql, values)
    artist_data = result[0]
    artist = Artist.new(artist_data)
    return artist
  end

  def update
    sql = "
    UPDATE albums
    SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4
    RETURNING *
    "
    values = [@title, @genre, @artist_id, @id]
    result = SqlRunner.run(sql, values)
    updated_album = Album.new(result[0])
    return updated_album
  end

  def delete
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Album.find(id) # READ
      sql = "SELECT * FROM albums WHERE id = $1"
      values = [id]
      results_array = SqlRunner.run(sql, values)
      return nil if results_array.first() == nil
      album_hash = results_array[0]
      found_album = Album.new(album_hash)
      return found_album
    end

end
