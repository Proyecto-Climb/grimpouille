# frozen_string_litteral: true

class Crag < ApplicationRecord
  belongs_to :sector
  has_many :climbing_routes, dependent: :destroy
end
