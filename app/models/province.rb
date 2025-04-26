# frozen_string_litteral: true

class Province < ApplicationRecord
  belongs_to :country

  has_many :regions, dependent: :destroy
  has_many :crags, through: :regions
  has_many :sectors, through: :crags
  has_many :climbing_routes, through: :sectors

  validates :name, presence: true
end
