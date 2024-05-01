# frozen_string_litteral: true

class Route < ApplicationRecord
  belongs_to :crag
  has_many :climbs, dependent: :destroy

  enum style: {
    sport: 1,
    trad: 2,
    mixed: 3
  }

  enum angle: {
    slab: 1,
    vertical: 2,
    slight_overhang: 3,
    overhang: 4,
    roof: 5
  }
end
