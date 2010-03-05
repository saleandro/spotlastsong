module Lastfm
  class User

    def initialize(username)
      @username = username
    end

    def loved_tracks
      tracks_json = json_data_from("method=user.getlovedtracks&format=json&user=#{@username}")
      return (tracks_json["lovedtracks"] and tracks_json["lovedtracks"]["track"]) ? tracks_json["lovedtracks"]["track"] : []
    end

    def top_tracks(period="7day")
      tracks_json = json_data_from("method=user.gettoptracks&period=#{period}&format=json&user=#{@username}")
      return (tracks_json["toptracks"] and tracks_json["toptracks"]["track"]) ? tracks_json["toptracks"]["track"] : []
    end

    def recent_tracks
      tracks_json = json_data_from("method=user.getrecenttracks&format=json&user=#{@username}")
      tracks = (tracks_json["recenttracks"] and tracks_json["recenttracks"]["track"]) ? tracks_json["recenttracks"]["track"] : []
      tracks.each do |track|
        track["artist"]["name"] = track["artist"]["#text"]
      end
      tracks
    end

    def playlists
      playlists = []
      playlists_json = json_data_from("method=user.getplaylists&format=json&user=#{@username}")
      return playlists unless playlists_json["playlists"] and playlists_json["playlists"]["playlist"]

      playlists_json["playlists"]["playlist"] = [playlists_json["playlists"]["playlist"]] if playlists_json["playlists"]["playlist"].is_a? Hash
      playlists_json["playlists"]["playlist"].each do |playlist|
        playlists << lastfm_user_playlist(playlist["id"])
      end
      playlists.compact!
      return playlists
    end

    def playlist(id)
      playlist_url = "lastfm://playlist/#{id}"
      playlists_json = json_data_from("method=playlist.fetch&playlistURL=#{playlist_url}&format=json")
      if playlist = playlists_json["playlist"]
        playlist["trackList"]["track"] = [playlist["trackList"]["track"]] if playlist["trackList"]["track"].is_a? Hash
        playlist
      end
    end
  end
end