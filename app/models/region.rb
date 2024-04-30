# frozen_string_litteral: true

class Region < ApplicationRecord
  has_many :sectors, dependent: :destroy
end
