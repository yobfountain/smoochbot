task :cron => :environment do

 if Time.now.hour == 0 # run at midnight
   Notifications.admin.deliver
 end
end