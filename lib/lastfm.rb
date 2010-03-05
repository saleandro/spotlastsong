require 'lib/json_api'

require 'lib/lastm/user'

module Lastfm
  extend JsonApi

  private

  def self.api_root
    'http://ws.audioscrobbler.com/2.0/'
  end

  def self.api_key_query_string
    "api_key=#{api_key}"
  end

  def self.api_key
  end

end