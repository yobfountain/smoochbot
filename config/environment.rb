# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Smoochbot::Application.initialize!

Smoochbot::Application.configure do
  if Rails.env == 'production'
    config.action_mailer.default_url_options = { :host => 'smoochbot.heroku.com' }
  else
    config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  end
end