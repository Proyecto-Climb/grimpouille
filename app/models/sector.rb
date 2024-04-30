# frozen_string_litteral: true

class Sector < ApplicationRecord
  belongs_to :region
  has_many :crags, dependent: :destroy
end
