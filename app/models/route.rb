# frozen_string_litteral: true

class Route < ApplicationRecord
  belongs_to :crag
  has_many :climbs, dependent: :destroy
end
