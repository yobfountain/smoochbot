class Notifications < ActionMailer::Base
  default :from => "bot@smoochbot.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #   en.notifications.admin.subject
  
  def admin(smoochees, smooched)
    @smoochees = smoochees
    @smooched = smooched
    @greeting = "Hi"
    mail :subject  => 'Smoochbot Report', :to => 'brian@brianfountain.com'
  end

  def article(smoochee, article, host="smoochbot.heroku.com")
    smoochee.mailings.create( :article => article, :time_sent => Time.now )
    smoochee.update_attribute( :last_smooched, Time.now )
    
    @smoochee = smoochee
    @article = article
    @host = host
    mail :subject => 'Your requested smoochmail', :to => smoochee.email
    # recipients smoochee.email
    # sent_on    sent_at    
    # body       :smoochee => smoochee, :article => article
  end

  def article_suggested
    @greeting = "Hi"
    mail :subject => 'Article Suggested', :to => "brian@brianfountain.com"
  end

  def confirmation(smoochee, host)
    @smoochee = smoochee
    @host = host
    mail :to => smoochee.email, :subject => 'Smoochbot Activation Email'
  end
  
  def cron
     mail :subject  => 'Cron Ran', :to => 'brian@brianfountain.com'
   end
   
end
