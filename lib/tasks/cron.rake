task :cron => :environment do

 if Time.now.hour == 10 && Time.now.min == 35 # run at 10:35 (PST)
   Notifications.cron.deliver
   # Article.mail_all
 end
end