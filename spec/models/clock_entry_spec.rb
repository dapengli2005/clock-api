require 'rails_helper'

RSpec.describe ClockEntry, type: :model do
  let(:user) { User.new }
  subject { described_class.new(user: user) }

  it 'is valid with valid attributes' do
    subject.action_type = 'IN'
    subject.datetime = DateTime.now

    expect(subject).to be_valid
  end

  it 'is not valid when action_type is missing' do
    subject.datetime = DateTime.now

    expect(subject).to_not be_valid
  end

  it 'is not valid when action_type is not supported' do
    subject.action_type = 'FOO'
    subject.datetime = DateTime.now

    expect(subject).to_not be_valid
  end

  it 'is not valid when datetime is missing' do
    subject.action_type = 'IN'

    expect(subject).to_not be_valid
  end

  it 'is not valid when datetime is in the future' do
    subject.action_type = 'IN'
    subject.datetime = DateTime.now + 6.minutes

    expect(subject).to_not be_valid
  end
end
