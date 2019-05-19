class User < ApplicationRecord
  has_many :clock_entries

  validates :username, presence: true
end
