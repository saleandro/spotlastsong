require 'rubygems'
require 'sinatra'

require 'lib/songkick'
require 'lib/spotify'

get '/spotlastsong' do
  erb :new
end

post '/spotlastsong' do
  if [params['songkick_username'], params['spotify_username'], params['spotify_password']].any?{|v| v.nil? || v.strip == ''}
    return erb(:new)
  end
  
  sk_user = Songkick::User.new(params['songkick_username'])
  spotify_user = Spotify::User.new(params['spotify_username'], params['spotify_password'])
  sk_user.past_events.each do |event|
    event.setlists.each do |setlist|
      begin
        spotify_user.create_playlist(event, setlist)
      rescue
      end
    end
  end
  
  erb :create
end