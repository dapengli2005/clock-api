require 'rails_helper'

RSpec.describe 'routing', :aggregate_failures, type: :routing do
  it 'routes for users' do
    expect(get: '/users/1').to route_to(
      controller: 'users', action: 'show', id: '1'
    )

    expect(post: '/users/login').to route_to(
      controller: 'users', action: 'login'
    )
  end

  it "routes for clock entries" do
    expect(get: '/users/1/clock_entries').to route_to(
      controller: 'clock_entries', action: 'index', user_id: '1'
    )

    expect(post: '/users/1/clock_entries').to route_to(
      controller: 'clock_entries', action: 'create', user_id: '1'
    )

    expect(get: '/users/1/clock_entries/2').to route_to(
      controller: 'clock_entries', action: 'show', user_id: '1', id: '2'
    )

    expect(put: '/users/1/clock_entries/2').to route_to(
      controller: 'clock_entries', action: 'update', user_id: '1', id: '2'
    )

    expect(delete: '/users/1/clock_entries/2').to route_to(
      controller: 'clock_entries', action: 'destroy', user_id: '1', id: '2'
    )

    expect(get: '/users/1/clock_entries/next').to route_to(
      controller: 'clock_entries', action: 'next', user_id: '1'
    )
  end
end
