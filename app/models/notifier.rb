class Notifier < ActionMailer::Base

  default_url_options[:host] = AppConfig.default_url_options

  def register_complete(user)
    subject       "Регистрация на сайте"
    from          AppConfig.noreply_email
    recipients    user.email
    sent_on       Time.now
  end

end
