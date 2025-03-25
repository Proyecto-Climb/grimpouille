class Country < ApplicationRecord
  has_many :provinces, dependent: :destroy
end
