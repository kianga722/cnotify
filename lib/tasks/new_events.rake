desc 'Send new events notification'
task :send_new_events => :environment do
  EventMailer.new_events.deliver
end