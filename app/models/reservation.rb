class Reservation < ApplicationRecord
  belongs_to :guest

  validates :reservation_code, uniqueness: true, presence: true
  validates :guest_id, presence: true
end
