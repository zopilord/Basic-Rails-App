if Rails.env.development?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => "app19187882@heroku.com",
    :password       => "eulvfhvj",
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }
end