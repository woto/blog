class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :current_user
  
  before_filter :date

  def date
    if params[:date] =~ /^\d+-\d+-00$/ 

=begin
require 'date'

local = DateTime.now
utc = local.new_offset

puts local.offset                  # => Rational(-5, 24)
puts local_from_utc = utc.new_offset(local.offset)
puts local_from_utc.to_s           # => "2006-03-18T20:15:58-0500"
puts local == local_from_utc       # => true

todo убрать Rational!!!
=end
    
    
      @date = DateTime.strptime(params[:date], "%Y-%m").new_offset(DateTime.now.offset
)
    elsif params[:date] =~ /^\d+-\d+-\d+$/
      @date = DateTime.strptime(params[:date], "%Y-%m-%d").new_offset(DateTime.now.offset
)
    else
      @date = DateTime.now
    end
    #debugger
    #local = @date
    #utc = local.new_offset
    #@date = utc
    #debugger
    #Time.zone.local_to_utc()
    #@date = @date.to_time(:local)
  end

  before_filter :load_posts_for_calendar

  def load_posts_for_calendar
    # Данная проверка нужна для того чтобы не загружать здесь @calendar_posts
    # а получать их в post::calendar. Пока что более грамотного способа не знаю
    if !request.xhr?
      @calendar_posts = CalendarPosts::get_calendar_posts params, @date, false
    end

  end

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

      store_location
      subject = exception.subject
      action = exception.action
      @exception = exception
      flash.now[:error] = "Извините, у вас недостаточно прав чтобы сделать желаемое действие"
      
      if subject.class == UserSession
        if action == :new
          flash.now[:error] = "Вы должны выйти из под своего аккаунта прежде чем сможете повторно войти"
          empty_location
        end
      elsif subject.class == User
        if action == :new
          flash.now[:error] = "Вы должны выйти из под своего аккаунта прежде чем сможете повторно зарегистрироваться"
          empty_location
        end
      end
      
      if subject == UserSession then 
        if action == :destroy
          flash[:error] = "Вы не находитесь под каким-либо аккаунтом чтобы имели возможность выйти"
          empty_location
          redirect_to login_url and return
        end
      elsif subject == User then
        if action == :edit
          flash.now[:error] = "Вы должны войти под своим аккаунтом прежде чем сможете отредактировать свой профиль"
          redirect_to login_url and return
        elsif action == :show
          flash[:error] = "Вы должны войти под своим аккаунтом прежде чем сможете просматирваить свой профиль"
          redirect_to login_url and return
        elsif action == :destroy
          flash[:error] = "Вы не можете удалить свой аккаунт, т.к. не залогинены на сайте"
          empty_location
          redirect_to login_url and return
        end
      end

      render 'errors/index'
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end

    def empty_location
      session[:return_to] = nil
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

  def default_url_options(options = nil)
    options ||= {}
    options[:format] = :iframe if params[:format] == "iframe"
    options
  end

end
