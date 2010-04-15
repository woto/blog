class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.deliver_register_complete!
      flash[:notice] = "Вы успешно зарегистрировались"
      redirect_back_or_default user_url
    else
      render :action => :new
    end
  end

  def show
    @user = @current_user
  end
end
