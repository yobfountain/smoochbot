class Notifications < ActionMailer::Base
  default :from => "bot@smoochbot.com"
  # TODO need to set up default_admin_email
  admin_email = ENV['SMOOCHBOT_ADMIN_EMAIL']

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #   en.notifications.admin.subject
  
  def admin(smoochees, smooched)
    @smoochees = smoochees
    @smooched = smooched
    @greeting = "Hi"
    mail :subject  => 'Smoochbot Report', :to => ENV['SMOOCHBOT_ADMIN_EMAIL'] #TODO DRY this up
  end

  def article(smoochee, article, host="smoochbot.heroku.com")
    smoochee.mailings.create( :article => article, :time_sent => Time.now )
    smoochee.update_attribute( :last_smooched, Time.now )
    
    @smoochee = smoochee
    @article = article
    @host = host
    mail :subject => 'Your requested smoochmail', :to => smoochee.email
  end

  def article_suggested
    @greeting = "Hi"
    mail :subject => 'Article Suggested', :to => ENV['SMOOCHBOT_ADMIN_EMAIL'] #TODO DRY this up
  end

  def confirmation(smoochee, host)
    @smoochee = smoochee
    @host = host
    mail :to => smoochee.email, :subject => 'Smoochbot Activation Email'
  end
  
  def cron
     mail :subject  => 'Cron Ran', :to => ENV['SMOOCHBOT_ADMIN_EMAIL'] #TODO DRY this up
   end
   
end
