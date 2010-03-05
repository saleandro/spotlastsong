require 'thrift'
require './lib/spotify/gen-rb/playlist_gen'

module Spotify
  class User

    def initialize(username, password)
      @username = username
      @password = password
    end

    def create_playlist(event, setlist)
      tracks = setlist["setlistItem"].map {|s| {"artist" => setlist["displayName"], "name" => s["name"]}}
      title = "#{setlist["displayName"]} at #{event.venue_name} (#{event.date})" 
      PlaylistgenClient.create_playlist(title, tracks, @username, @password)
    end

  end

  class PlaylistgenClient
    HOST = "127.0.0.1"
    PORT = 5000

    def self.create_playlist(title, tracks, username, password)
      with_playlistgen_client do |client|
        session_for(client, username, password) do |session|
          playlist = TPlaylist.new
          playlist.name = title
          playlist.tracks = []
          tracks.each do |track|
            ttrack = TTrack.new
            ttrack.artistName = track["artist"]
            ttrack.title = track["name"]
            playlist.tracks << ttrack
          end

          client.createPlaylist(session, playlist)

          return [client.getPlaylist(session, playlist.name)]
        end
      end
    end

    private

    def self.with_playlistgen_client
      begin
        transport = Thrift::BufferedTransport.new(Thrift::Socket.new(HOST, PORT))
        protocol  = Thrift::BinaryProtocol.new(transport)
        client    = PlaylistGen::Client.new(protocol)
        transport.open
        yield client
      ensure
         transport.close
      end
    end

    def self.session_for(client, username, password)
      session = client.login(username, password)
      raise Exception.new("Could not log you in on spotify!") unless session
      yield session
      client.logout(session)
    end
  end

end
