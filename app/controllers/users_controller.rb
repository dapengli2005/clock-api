class UsersController < ApplicationController
  def login
    user = User.find_or_create_by(username: params[:username])
    render json: user, status: :ok
  end

  def show
    user = User.find(params[:id])
    render json: user, status: :ok
  end
end
