class Province < ApplicationRecord
  belongs_to :country
  has_many :regions, dependent: :destroy
  has_many :crags, through: :regions
  has_many :sectors, through: :crags
  has_many :routes, through: :sectors
end
