require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:users) { create_list(:user, 2) }
  let(:user) { users.first }
  let(:whitelist_json_keys) { %w(id username) }
  let(:blacklist_json_keys) { %w(created_at updated_at) }

  describe 'GET /users/:id' do
    before { get "/users/#{user.id}" }

    let(:json) { JSON.parse(response.body) }

    specify { expect(json).not_to be_empty }
    specify { expect(json).to have_valid_serialization_keys }
    specify { expect(response).to have_http_status(200) }
  end

  describe 'POST /users/login' do
    context 'user does not exist' do
      before { login(user.username) }

      let(:json) { JSON.parse(response.body) }

      specify { expect(json).not_to be_empty }
      specify { expect(json).to have_valid_serialization_keys}
      specify { expect(response).to have_http_status(200) }
      specify { expect { login(user.username) }.not_to change { User.count } }
    end

    context 'user already exist' do
      before { login }

      let(:json) { JSON.parse(response.body) }

      specify { expect(json).not_to be_empty }
      specify { expect(json).to have_valid_serialization_keys}
      specify { expect(response).to have_http_status(200) }
      specify { expect { login }.to change { User.count }.by(1) }
    end
  end

  private

  def login(username = Faker::Lorem.unique.word)
    post '/users/login', params: { username: username }
  end

  def have_valid_serialization_keys
    have_keys(whitelist_json_keys).and_not_have_keys(blacklist_json_keys)
  end
end
