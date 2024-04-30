# frozen_string_litteral: true

class Crag < ApplicationRecord
  belongs_to :sector
  has_many :routes, dependent: :destroy
end
