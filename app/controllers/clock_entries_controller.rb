class ClockEntriesController < ApplicationController
  before_action :set_user

  PAGE_SIZE = 2

  def index
    entries = @user.clock_entries.by_date_desc.page(params[:page] ? params[:page].to_i : 1).per(PAGE_SIZE)
    render json: { data: entries, meta: meta_for(entries) }, status: :ok
  end

  def show
    entry = @user.clock_entries.find(params[:id])
    render json: entry, status: :ok
  end

  def create
    entry = @user.clock_entries.create(action_type: params[:action_type],
                                       note: params[:note],
                                       datetime: DateTime.now)
    render json: entry, status: :created
  end

  def update
    entry = @user.clock_entries.find(params[:id])
    entry.update(action_type: params[:action_type],
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
    render json: { user_id: @user.id, type: flip_action_type(last_entry) }, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def flip_action_type(clock_entry)
    clock_entry&.action_type == 'IN' ? 'OUT' : 'IN'
  end

  def meta_for(items)
    meta = {}
    meta[:next] = meta_for_page(items.next_page) if items.next_page
    meta[:prev] = meta_for_page(items.prev_page) if items.prev_page
    meta
  end

  def meta_for_page(num)
    {
      method: 'GET',
      url: "#{user_clock_entries_url}?page=#{num}"
    }
  end
end
