class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])

    render :new, status: :unprocessable_entity unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to "/users/#{@user.username}",
        notice: t("User was successfully created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :username)
  end
end
