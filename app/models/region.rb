# frozen_string_litteral: true

class Region < ApplicationRecord
  belongs_to :province
  has_many :sectors, dependent: :destroy

  validates :name, presence: true
end
