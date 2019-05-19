class UsersController < ApplicationController
  SERIALIZATION_FIELDS = [:id, :username]

  def login
    user = User.find_or_create_by!(username: params[:username])
    render json: as_json(user), status: :ok
  end

  def show
    user = User.find(params[:id])
    render json: as_json(user), status: :ok
  end

  private

  def as_json(user)
    user.as_json(only: SERIALIZATION_FIELDS)
  end
end
