# frozen_string_litteral: true

class Route < ApplicationRecord
  include GradesConversionService

  belongs_to :crag
  has_one :sector, through: :crag
  has_one :region, through: :sector
  has_one :province, through: :region
  has_one :country, through: :province
  has_many :climbs, dependent: :destroy
  has_many :pitches, dependent: :destroy

  enum :style, {
    sport: 1,
    trad: 2,
    mixed: 3,
    top_rope: 4,
    unknown: 5
  }

  enum :angle, {
    slab: 1,
    vertical: 2,
    slight_overhang: 3,
    overhang: 4,
    roof: 5
  }

  before_commit :set_standardized_grade

  private

  def set_standardized_grade
    case country.grading_system
      when 'YDS'
        clean_grade = clean_up_yds_grade(grade)
        self.standardized_grade = YDS[clean_grade]
      when 'EU'
        # self.standardized_grade = EU_SYSTEM[grade]
      end

      self.grade = clean_grade
  end
end
