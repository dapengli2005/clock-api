class User < ApplicationRecord
  has_many :clock_entries
end
