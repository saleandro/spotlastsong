require 'open-uri'
require 'json'

module JsonApi

  def json_data_from(path)
    path = path[1..-1] if path[0,1] == '/'
    sep = path && path.match(/\?/) ? '&' : '?'

    url = "#{api_root}#{path}#{sep}#{api_key_query_string}"
    puts url
    JSON.parse(open(url).read)
  rescue URI::InvalidURIError
    return nil
  rescue OpenURI::HTTPError => e
    unless e.message =~ /404/
      raise e
    end
  end

  def api_key_query_string
    raise "Implement me"
  end

  def api_root
    raise "Implement me"
  end
end