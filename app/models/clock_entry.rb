class ClockEntry < ApplicationRecord
  belongs_to :user

  ALLOWED_ACTION_TYPES = %w(IN OUT)
  DATETIME_GRACE_PERIOD = 5.minutes  # in case user's clock is not synced (not likely, but just in case)

  validates :action_type,
    inclusion: { in: ALLOWED_ACTION_TYPES,
                 message: "%{value} is not supported, must be one of #{ALLOWED_ACTION_TYPES}" }
  validates :datetime, presence: true
  validate :datetime_not_in_future, if: -> { datetime }

  scope :by_date_desc, -> { order(datetime: :desc) }

  private

  def datetime_not_in_future
    if datetime > DateTime.now + DATETIME_GRACE_PERIOD
      errors.add(:datetime, 'cannot be in the future')
    end
  end
end
