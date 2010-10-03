# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Smoochbot::Application.initialize!

Smoochbot::Application.configure do
  if Rails.env != 'production'
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => 'brianfountain.com',
      :user_name            => 'vpotus@gmail.com',
      :password             => 'fourteen',
      :authentication       => 'plain',
      :enable_starttls_auto => true  }
  end
end