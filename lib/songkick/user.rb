module Songkick
  class User
    def initialize(username)
     @username = username
    end

    def past_events
      events = []
      per_page = total = nil
      page = 0

      while !per_page || (page*per_page) < total
        json_page = Songkick.json_data_from(past_events_path(page+1))["resultsPage"]
        page      = json_page["page"]
        per_page  = json_page["perPage"]
        total     = json_page["totalEntries"]

        events += json_page["results"]["event"].map {|e| Event.new(e)}
      end
      events
    end

    private

    def past_events_path(page=1)
      end_date = (Date.today - 1).to_s
      "users/#{@username}/events.json?page=#{page}" +
            "&attendance=im_going&min_date=1900-01-01&max_date=#{end_date}"
    end
  end
end