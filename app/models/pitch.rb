# frozen_string_litteral: true

class Pitch < ApplicationRecord
  belongs_to :climbing_route

  validates :length, :position, :pitch_grade, presence: true
end
