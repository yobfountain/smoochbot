class Notifications < ActionMailer::Base
  default :from => "vpotus@gmail.com"
  # smtp_settings :port => 587, :authentication => :login, :enable_starttls_auto => true, :password => "fourteen"
  #   raise_delivery_errors = true

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #   en.notifications.admin.subject
  
  def admin
    @greeting = "Hi"
    mail :subject  => 'Smoochbot Report', :to => 'brian@brianfountain.com'
  end

  def article(smoochee, article)
    smoochee.mailings.create( :article => article, :time_sent => Time.now )
    smoochee.update_attribute( :last_smooched, Time.now )
    
    @smoochee = smoochee
    @article = article
    mail :subject => 'Your requested smoochmail', :to => smoochee.email
    # recipients smoochee.email
    # sent_on    sent_at    
    # body       :smoochee => smoochee, :article => article
  end

  def article_suggested
    @greeting = "Hi"
    mail :subject => 'Article Suggested', :to => "brian@brianfountain.com"
  end

  def confirmation(smoochee)
    @smoochee = smoochee
    mail :to => smoochee.email, :subject => 'Smoochbot Activation Email'
  end
  
  def cron
     mail :subject  => 'Cron Ran', :to => 'brian@brianfountain.com'
   end
   
end
