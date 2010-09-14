class Notifications < ActionMailer::Base
  default :from => "vpotus@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #   en.notifications.admin.subject
  
  def admin(sent_at = Time.now)
    mail (:subject  => 'Smoochbot Report', :to => 'brian@brianfountain.com')
    sent_on    sent_at
    @greeting = "Hi"
  end

  def article(smoochee, article, sent_at = Time.now)
    smoochee.mailings.create( :article => article, :time_sent => sent_at )
    smoochee.update_attribute( :last_smooched, sent_at )
    mail ( :subject => 'Your requested smoochmail')
    recipients smoochee.email
    sent_on    sent_at    
    body       :smoochee => smoochee, :article => article
  end

  def article_suggested(sent_at = Time.now)
    @greeting = "Hi"
    mail (:subject => 'Article Suggested', :to => "brian@brianfountain.com")
    sent_on    sent_at
  end

  def confirmation(smoochee, sent_at = Time.now)
    subject    'Smoochbot Activation Email'
    recipients smoochee.email
    sent_on    sent_at    
    body       :smoochee => smoochee
  end
end
