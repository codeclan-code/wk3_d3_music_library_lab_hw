require_relative('../db/sql_runner')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "
    INSERT INTO artists (name)
    VALUES ($1)
    RETURNING id
    "
    values = [@name]
    result  = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def Artist.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def Artist.all
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Artist.new(artist) }
  end

  def  all_albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values =[@id]
    albums_data = SqlRunner.run(sql, values)
    albums = albums_data.map { |album_data| Album.new(album_data)}
    return albums
  end

  def update
    sql = "
    UPDATE artists
    SET name = $1 WHERE id = $2
    RETURNING *
    "
    values = [@name, @id]
    result = SqlRunner.run(sql, values)
    updated_artist = Artist.new(result[0])
    return updated_artist
  end

  def delete
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  #
  def Artist.find(id) # READ
      sql = "SELECT * FROM artists WHERE id = $1"
      values = [id]
      results_array = SqlRunner.run(sql, values)
      return nil if results_array.first() == nil
      artist_hash = results_array[0]
      found_artist = Artist.new(artist_hash)
      return found_artist
    end



end
