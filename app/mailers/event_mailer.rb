class EventMailer < ApplicationMailer

  require 'open-uri'

  def new_events
    file = File.join(Rails.root, 'app','artistList.txt')
    artistList = File.readlines(file).map { |line| line.chomp }

    stateList = ['New York']

    url = 'https://edmtrain.com/api/events?&client='+ENV['EDM_API_KEY']
    events = JSON.parse(open(url).read)

    artistListDowncase = artistList.map { |x| x.downcase }
    stateListDowncase = stateList.map { |x| x.downcase }
    lastWeek = (Time.now - (7*24*60*60)).strftime('%Y-%m-%d')
    @artists = []
    @dressCode = ['Lavo', 'Marquee'];
    @events = []
    events['data'].each do |event|
      #Check if event is in desired state and recent
      if (stateListDowncase.include?(event['venue']['state'].downcase) && event['createdDate'] > lastWeek)
        #Check if artists are part of event
        event['artistList'].each do |artist|
          if artistListDowncase.include?(artist['name'].downcase)
            @events << event    

            @artists << artist['name'] unless @artists.include?(artist['name'])   
            
            break
          end
        end
      end
    end

    mail to: ENV['EMAIL'], subject: 'New Events'
  end

 

end
