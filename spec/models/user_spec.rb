require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new }

  it 'is valid with valid attributes' do
    subject.username = 'John'

    expect(subject).to be_valid
  end

  it 'is not valid when username is missing' do
    expect(subject).to_not be_valid
  end

  it 'is not valid when username is empty' do
    subject.username = ''

    expect(subject).to_not be_valid
  end
end
