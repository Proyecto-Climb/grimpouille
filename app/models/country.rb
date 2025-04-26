# frozen_string_litteral: true

class Country < ApplicationRecord
  has_many :provinces, dependent: :destroy

  validates :name, :grading_system, presence: true
  validates :grading_system, inclusion: { in: GradesConversionService::GRADING_SYSTEMS }
end
