# frozen_string_litteral: true

class Pitch < ApplicationRecord
  belongs_to :climbing_route

  validates :length, :position, :pitch_grade, presence: true

  enum :angle, {
    unknown: 0,
    slab: 1,
    vertical: 2,
    slight_overhang: 3,
    overhang: 4,
    roof: 5
  }, validate: true
end
