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

  def create
    entry = @user.clock_entries.create(action_type: params[:type],
                                       note: params[:note],
                                       datetime: DateTime.now)
    render json: entry, status: :created
  end

  def update
    entry = @user.clock_entries.find(params[:id])
    entry.update(action_type: params[:type],
                 note: params[:note],
                 datetime: params[:datetime])

    render json: entry, status: :ok
  end

  def destroy
    entry = @user.clock_entries.find(params[:id])
    entry.destroy
    head :no_content
  end

  def next
    last_entry = @user.clock_entries.last
    render json: { userId: @user.id, type: flip_action_type(last_entry) }, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def flip_action_type(clock_entry)
    clock_entry&.action_type == 'IN' ? 'OUT' : 'IN'
  end
end
