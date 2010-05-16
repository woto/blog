class Notifier < ActionMailer::Base

  default_url_options[:host] = AppConfig.default_url_options

  def register_complete(user)
    subject       "Регистрация на сайте"
    from          "#{AppConfig.noreply_name} <#{AppConfig.noreply_email}>"
    recipients    user.email
    sent_on       Time.now
  end

  def password_reset_instructions(user)
    subject       I18n.t('notifier.titles.password_reset_instructions')
    from          "#{AppConfig.noreply_name} <#{AppConfig.noreply_email}>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end


end
