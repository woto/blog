class UserSessionsController < ApplicationController

  load_and_authorize_resource

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      if @user_session.new_registration?
        flash[:notice] = "Вы успешно зарегистрировались, и вошли на сайт"
        redirect_back_or_default user_url
      else
      #  if @user_session.registration_complete?
          flash[:notice] = "Рады Вас снова видеть на нашем сайте"
          redirect_back_or_default root_path
      #  else
      #    flash[:notice] = "С возвращением, пожалуйста проверьте ваши данные перед тем как продолжите работу с сайтом"
      #    redirect_back_or_default edit_user_url
      #  end
      end
    else
      render :action => :new
    end
  end

  def destroy
    @user_session = current_user_session
    if(@user_session)
      @user_session.destroy
      flash[:notice] = "Вы успешно вышли"
    end
    redirect_back_or_default root_url
  end
end
