#
# Autogenerated by Thrift
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#


class TTrack
  include ::Thrift::Struct
  TITLE = 1
  ARTISTNAME = 2

  ::Thrift::Struct.field_accessor self, :title, :artistName
  FIELDS = {
    TITLE => {:type => ::Thrift::Types::STRING, :name => 'title'},
    ARTISTNAME => {:type => ::Thrift::Types::STRING, :name => 'artistName'}
  }

  def struct_fields; FIELDS; end

  def validate
  end

end

class TPlaylist
  include ::Thrift::Struct
  NAME = 1
  TRACKS = 2

  ::Thrift::Struct.field_accessor self, :name, :tracks
  FIELDS = {
    NAME => {:type => ::Thrift::Types::STRING, :name => 'name'},
    TRACKS => {:type => ::Thrift::Types::LIST, :name => 'tracks', :element => {:type => ::Thrift::Types::STRUCT, :class => TTrack}}
  }

  def struct_fields; FIELDS; end

  def validate
  end

end

class TSession
  include ::Thrift::Struct
  TOKEN = 1

  ::Thrift::Struct.field_accessor self, :token
  FIELDS = {
    TOKEN => {:type => ::Thrift::Types::STRING, :name => 'token'}
  }

  def struct_fields; FIELDS; end

  def validate
  end

end

class SpotifyException < ::Thrift::Exception
  include ::Thrift::Struct
  def initialize(message=nil)
    super()
    self.msg = message
  end

  def message; msg end

  MSG = 1

  ::Thrift::Struct.field_accessor self, :msg
  FIELDS = {
    MSG => {:type => ::Thrift::Types::STRING, :name => 'msg'}
  }

  def struct_fields; FIELDS; end

  def validate
  end

end

class SessionExpiredException < ::Thrift::Exception
  include ::Thrift::Struct
  def initialize(message=nil)
    super()
    self.msg = message
  end

  def message; msg end

  MSG = 1

  ::Thrift::Struct.field_accessor self, :msg
  FIELDS = {
    MSG => {:type => ::Thrift::Types::STRING, :name => 'msg'}
  }

  def struct_fields; FIELDS; end

  def validate
  end

end

