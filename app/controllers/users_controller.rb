class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])

    render :new, status: 404 unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
  end

  private

  def user_params
    params.require(:user).permit(:name, :username)
  end
end
