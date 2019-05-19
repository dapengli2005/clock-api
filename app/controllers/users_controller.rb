class UsersController < ApplicationController
  SERIALIZATION_FIELDS = [:id, :username]

  def login
    # validation at DTO level, returns 400 Bad Request if invalid
    params.require(:username)

    user = User.find_or_create_by!(username: params[:username])
    render json: as_json(user)
  end

  def show
    user = User.find(params[:id])
    render json: as_json(user)
  end

  private

  def as_json(user)
    user.as_json(only: SERIALIZATION_FIELDS)
  end
end
