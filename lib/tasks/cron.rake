task :cron => :environment do

 if Time.now.hour == 10 && Time.now.min == 15 # run at 10:15
   Notifications.cron.deliver
   # Article.mail_all
 end
end