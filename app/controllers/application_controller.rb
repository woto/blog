class ApplicationController < BaseController
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :current_user
  
  helper_method :current_user, :current_user_session

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  private
    
    rescue_from CanCan::AccessDenied do |exception|
      subject = exception.subject
      action = exception.action
      @exception = exception
      flash.now[:error] = "Извините, у вас недостаточно прав чтобы сделать желаемое действие"
      
      if subject.class == UserSession
        if action == :new
          flash.now[:error] = "Вы должны выйти из под своего аккаунта прежде чем сможете повторно войти"
        end
      elsif subject.class == User
        if action == :new
          flash.now[:error] = "Вы должны выйти из под своего аккаунта прежде чем сможете повторно зарегистрироваться"
        end
        store_location
      end
      
      if subject == UserSession then 
        if action == :destroy
          flash[:error] = "Вы не находитесь под каким-либо аккаунтом чтобы имели возможность выйти"
          redirect_to login_url and return
        end
      elsif subject == User then
        if action == :edit
          flash.now[:error] = "Вы должны войти под своим аккаунтом прежде чем сможете отредактировать свой профиль"
          store_location
          redirect_to login_url and return
        elsif action == :show
          flash[:error] = "Вы должны войти под своим аккаунтом прежде чем сможете просматирваить свой профиль"
          store_location
          redirect_to login_url and return
        elsif action == :destroy
          flash[:error] = "Вы не можете удалить свой аккаунт, т.к. не залогинены на сайте"
          redirect_to login_url and return
        end
      end

      render 'errors/index'
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

end
