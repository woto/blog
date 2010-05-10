class UsersController < ApplicationController
  
  load_and_authorize_resource

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #@user.deliver_register_complete!
      flash[:notice] = "Вы успешно зарегистрировались и вошли на сайт"
      redirect_back_or_default user_url
    else
      render :action => :new
    end
  end
  
  def edit
    @user = @current_user
    #@user.login = @user.login
  end

  def show
    @user = @current_user
  end 

  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      flash[:notice] = "Данные аккаунта успешно обновлены"
      redirect_back_or_default edit_user_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    current_user.destroy
    current_user_session.destroy
    flash[:notice] = "Вы успешно удалили свой аккаунт"
    redirect_back_or_default root_url
  end

  def addrpxauth
    @user = current_user
    if @user.save
      flash.now[:notice] = "Выбранный вами аккаунт был успешно привязан к текущему"
      redirect_back_or_default user_path
      #render :action => 'show'
    else
      render :action => 'edit'
    end
  end

end
