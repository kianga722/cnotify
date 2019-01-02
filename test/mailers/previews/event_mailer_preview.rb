# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview

  def new_events
      EventMailer.new_events
  end

end
