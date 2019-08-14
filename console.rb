require('pry')
require_relative('./models/artist')
require_relative('./models/album')

# Album.delete_all()
# Artist.delete_all()

artist1 = Artist.new({'name' => 'Rolling Stones'})
artist2 = Artist.new({'name' => 'Arctic Monkeys'})

artist1.save()
artist2.save()

album1 = Album.new({
  'title' => 'Greatest Hits',
  'genre' => 'rock',
  'artist_id' => artist1.id()
  })

  album2 = Album.new({
    'title' => 'Whatever People Say I Am That\'s What I\'m Not',
    'genre' => 'rock',
    'artist_id' => artist2.id()
    })

    album3 = Album.new({
      'title' => 'AM Greatest Hits',
      'genre' => 'rock',
      'artist_id' => artist2.id()
      })

      album1.save()
      album2.save()
      album3.save()

      binding.pry
      nil
