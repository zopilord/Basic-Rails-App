if Rails.env.production?
	ActionMailer::Base.delivery_method = :Smtp
	ActionMailer::Base.smtp_settings = {
		:address => 'smtp.sengrid.net',
		:port => "587",
		:authentication => :plain,
		:user_name => ENV["SENGRID_USERNAME"],
		:password => ENV["SENGRID_PASSWORD"],
		:domain => "heroku.com",
		:enable_starttls_auto => true
	}
	
end