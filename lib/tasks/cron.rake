task :cron => :environment do
 Notifications.cron.deliver
 # Article.mail_all
end