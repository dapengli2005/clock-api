class ClockEntriesController < ApplicationController
  before_action :set_user

  PAGE_SIZE = 5
  SERIALIZATION_FIELDS = [:id, :user_id, :action_type, :datetime, :note]

  def index
    entries = @user.clock_entries
      .by_date_desc.page(params[:page] ? params[:page].to_i : 1)
      .per(PAGE_SIZE)

    entries_json = entries.map { |entry| as_json(entry) }

    render json: { data: entries_json, meta: meta_for(entries) }
  end

  def show
    entry = @user.clock_entries.find(params[:id])

    render json: as_json(entry)
  end

  def create
    # validation at DTO level, returns 400 Bad Request if invalid (without involing model validation)
    params.require(:action_type)

    # validation at Model level, returns 422 Unprocessable Entity if invalid (though not likely in this case)
    entry = @user.clock_entries.create!(action_type: params[:action_type],
                                        note: params[:note],
                                        datetime: params[:datetime] || DateTime.now)

    render json: as_json(entry), status: :created
  end

  def update
    entry = @user.clock_entries.find(params[:id])
    entry.action_type = params[:action_type] if params[:action_type]
    entry.note = params[:note] if params[:note]
    entry.datetime = params[:datetime] if params[:datetime]
    entry.save!

    render json: as_json(entry)
  end

  def destroy
    entry = @user.clock_entries.find(params[:id])
    entry.destroy

    head :no_content
  end

  def next
    last_entry = @user.clock_entries.by_date_desc.first
    body = {
      user_id: @user.id,
      action_type: ClockEntry.next_action(last_entry&.action_type)
    }

    render json: body
  end

  private

  def set_user
    @user = User.find(params[:user_id])
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

  def as_json(entry)
    entry.as_json(only: SERIALIZATION_FIELDS)
  end
end
