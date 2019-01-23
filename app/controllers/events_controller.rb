class EventsController < ApplicationController

  require 'open-uri'

  def index
    file = File.join(Rails.root, 'app','artistList.txt')
    artistList = File.readlines(file).map { |line| line.chomp }

    stateList = ['New York']

    url = 'https://edmtrain.com/api/events?&client='+ENV['EDM_API_KEY']
    events = JSON.parse(open(url).read)

    artistListDowncase = artistList.map { |x| x.downcase }
    stateListDowncase = stateList.map { |x| x.downcase }
    @events = []
    @artists = []
    @venues = []
    @dressCode = ['Lavo', 'Marquee'];
    @months = []  
    @dates = {}
    events['data'].each do |event|
      #Check if event is in desired state
      if (stateListDowncase.include?(event['venue']['state'].downcase))
        #Check if artists are part of event
        event['artistList'].each do |artist|
          if artistListDowncase.include?(artist['name'].downcase)
            @events << event

            @artists << artist['name'] unless @artists.include?(artist['name'])

            @venues << event['venue']['name'] unless @venues.include?(event['venue']['name'])
            
            #{'December': ['Mon, Dec 30', 'Tue Dec 31']}
            month = DateTime.parse(event['date']).strftime('%B %Y')
            day = DateTime.parse(event['date']).strftime('%a, %b %d')
            if @dates.keys.include?(month)
              @dates[month] << day unless @dates[month].include?(day)
            else
              @dates[month] = []
              @dates[month] << day
            end

            break
          end
        end
      end
    end

  end



end

