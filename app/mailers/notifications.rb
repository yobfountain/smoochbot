class Notifications < ActionMailer::Base
  default :from => "vpotus@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.admin.subject
  #
  def admin
    @greeting = "Hi"
    mail :to => "brian@brianfountain.com"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.article.subject
  #
  def article
    @smoochee = smoochee
    @article = article
    mail :to => "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.article_suggested.subject
  #
  def article_suggested
    @greeting = "Hi"

    mail :to => "brian@brianfountain.com"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.confirmation.subject
  #
  def confirmation
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
end
