require 'rails_helper'

RSpec.describe 'ClockEntries API', type: :request do
  let!(:user) { create(:user) }
  let!(:entries) { create_list(:clock_entry, 20, user_id: user.id) }
  let!(:entry) { entries.sample }
  let(:whitelist_json_keys) { %w(id user_id action_type datetime note) }
  let(:blacklist_json_keys) { %w(created_at updated_at) }

  describe 'GET /clock_entries' do
    before { get "/users/#{user.id}/clock_entries" }

    let(:items) { JSON.parse(response.body)['data'] }
    let(:meta) { JSON.parse(response.body)['meta'] }

    specify { expect(items.size).to eq(ClockEntriesController::PAGE_SIZE) }
    specify { expect(items).to all(have_valid_serialization_keys) }
    specify { expect(meta).not_to be_empty }
    specify { expect(response).to have_http_status(200) }
  end

  describe 'GET /clock_entries/:id' do
    before { get "/users/#{user.id}/clock_entries/#{entry.id}" }

    let(:json) { JSON.parse(response.body) }

    specify { expect(json).not_to be_empty }
    specify { expect(json).to have_valid_serialization_keys }
    specify { expect(response).to have_http_status(200) }
  end

  describe 'POST /clock_entries' do
    let(:valid_attributes) { { action_type: 'IN' } }
    before { post "/users/#{user.id}/clock_entries", params: valid_attributes }

    let(:json) { JSON.parse(response.body) }

    specify { expect(json).not_to be_empty }
    specify { expect(json).to have_valid_serialization_keys }
    specify { expect(response).to have_http_status(201) }
  end

  describe 'PUT /clock_entries/:id' do
    let(:valid_attributes) { { action_type: 'IN' } }
    before { put "/users/#{user.id}/clock_entries/#{entry.id}", params: valid_attributes }

    let(:json) { JSON.parse(response.body) }

    specify { expect(json).not_to be_empty }
    specify { expect(json).to have_valid_serialization_keys }
    specify { expect(response).to have_http_status(200) }
  end

  describe 'DELETE /clock_entries/:id' do
    before { delete "/users/#{user.id}/clock_entries/#{entry.id}" }

    specify { expect(response.body).to be_empty }
    specify { expect(response).to have_http_status(204) }
  end

  describe 'GET /clock_entries/next' do
    before { get "/users/#{user.id}/clock_entries/next" }

    let(:json) { JSON.parse(response.body) }

    specify { expect(json).not_to be_empty }
    specify { expect(json).to have_valid_minimal_serialization_keys }
    specify { expect(response).to have_http_status(200) }
  end

  private

  def have_valid_serialization_keys
    have_keys(whitelist_json_keys).and_not_have_keys(blacklist_json_keys)
  end

  def have_valid_minimal_serialization_keys
    have_keys(%w(user_id action_type)).and_not_have_keys(blacklist_json_keys)
  end
end
