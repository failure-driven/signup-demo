class UsersController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    if current_user
      redirect_to "/users/#{current_user.username}"
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find_by(username: params[:username])

    render 'devise/registrations/new', status: 422 unless @user
  end

  def new
    @user = User.new
    render 'devise/registrations/new'
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to "/users/#{@user.username}",
                  notice: 'User was successfully created.'
    else
      render 'devise/registrations/new', status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :username)
  end
end
