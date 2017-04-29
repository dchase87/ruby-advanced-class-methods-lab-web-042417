require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new
    self.all << song
    song
  end

  def self.new_by_name(name)
    song = self.new
    song.name=(name)
    song
  end

  def self.create_by_name(name)
    song = self.new
    song.name=(name)
    self.all << song
    song
  end

  def self.find_by_name(name)
    self.all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    if self.all.include?(song)
      song
    else
      self.create_by_name(name)
    end
  end

  def self.alphabetical
    self.all.sort_by {|song| song.name}
  end

  def self.normalized_file_array(file_name)
    song_data = file_name.split(' - ')
    song_data[1].chomp!('.mp3')
    song_data
  end

  def self.new_from_filename(file_name)
    artist = normalized_file_array(file_name)[0]
    song_name = normalized_file_array(file_name)[1]

    song = self.new
    song.name=(song_name)
    song.artist_name=(artist)

    song
  end

  def self.create_from_filename(file_name)
    artist = normalized_file_array(file_name)[0]
    song_name = normalized_file_array(file_name)[1]

    song = self.new
    song.name=(song_name)
    song.artist_name=(artist)

    self.all << song
    song
  end

  def self.destroy_all
    self.all.clear
  end

end
