require 'lib/json_api'

require 'lib/songkick/user'
require 'lib/songkick/event'

module Songkick

  extend JsonApi

  private

  def self.api_root
    'http://api.songkick.com/api/3.0/'
  end

  def self.api_key_query_string
    "apikey=#{api_key}"
  end

  def self.api_key
  end

end