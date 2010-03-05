module Songkick

  class Event

    attr_accessor :venue_name
    attr_accessor :name
    attr_accessor :date
            
    def initialize(event)
      @event_id = event["id"]
      @name = event["displayName"]
      @date = Date.parse(event["start"]["date"])
      @venue_name = event["venue"]["displayName"]
    end

    def setlists
      setlist = Songkick.json_data_from(setlist_path)
      if setlist["resultsPage"]["results"].any?
        return setlist["resultsPage"]["results"]["setlist"]
      else
        return []
      end
    end

    private
    
    def setlist_path
      "events/#{@event_id}/setlists.json"
    end

  end
end
