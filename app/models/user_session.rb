class UserSession < Authlogic::Session::Base
	rpx_key AppConfig.rpx_api_key
	rpx_extended_info
	find_by_login_method :find_by_login_or_email
  generalize_credentials_error_messages true
 
private

  def map_rpx_data
    self.attempted_record.send("#{klass.login_field}=", @rpx_data['profile']['displayName'] ) if attempted_record.send(klass.login_field).blank?
    self.attempted_record.send("#{klass.email_field}=", @rpx_data['profile']['email'] ) if attempted_record.send(klass.email_field).blank?
  end

end
