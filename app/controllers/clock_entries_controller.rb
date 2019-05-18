class ClockEntriesController < ApplicationController
  before_action :set_user

  def index
    entries = @user.clock_entries
    render json: { data: entries }, status: :ok
  end

  def show
    entry = @user.clock_entries.find(params[:id])
    render json: entry, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
