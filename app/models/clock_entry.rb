class ClockEntry < ApplicationRecord
  belongs_to :user

  scope :by_date_desc, -> { order(datetime: :desc) }
end
