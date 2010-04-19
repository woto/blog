# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user, :current_user_session
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  before_filter { |c| Authorization.current_user = c.current_user }

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
    logger.debug("current_user_session >>>>>>>>>>>>>>> ") + logger.debug(YAML::dump(current_user_session.user))
  end

  private

    def require_user
      unless current_user
        store_location
        flash[:notice] = "Вы должны войти под своим аккаунтом прежде чем получите доступ к запрошенной странице"
        redirect_to login_url
        return false
      end
    end


    def require_no_user
      if current_user
        store_location
        flash[:notice] = "Вы должны выйти из под своего аккаунта прежде чем получите доступ к запрошенной странице"
        redirect_to user_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

end
