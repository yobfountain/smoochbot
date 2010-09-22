task :cron => :environment do

 if Time.now.hour == 10 && Time.now.min == 50 # run at midnight
   Notifications.cron.deliver
   # Article.mail_all
 end
end