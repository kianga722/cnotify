class EventMailer < ApplicationMailer

  def new_events
    @greeting = 'wasup'

    mail to: ENV['EMAIL'], subject: 'New Events'
  end

end
