class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    if logged_in?
      @user = User.find(params[:id])
    else
      flash[:notice] = 'create login'
      redirect_to new_session_path
    end
  end
  private
   def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end
end
