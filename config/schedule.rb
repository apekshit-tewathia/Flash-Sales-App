set :output, "#{path}/log/cron.log"
set :environment, 'development'
 
every 1.days, at: '10:00 am' do
  rake 'deal:publish_and_unpublish'
end
