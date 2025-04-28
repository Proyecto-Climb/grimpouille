# frozen_string_litteral: true

class ClimbingRoute < ApplicationRecord
  include GradesConversionService

  belongs_to :crag
  has_one :sector, through: :crag
  has_one :region, through: :sector
  has_one :province, through: :region
  has_one :country, through: :province

  has_many :climbs, dependent: :destroy
  has_many :pitches, dependent: :destroy

  validates :name, :grade, :height, presence: true
  validates :height, numericality: { only_integer: true }

  enum :style, {
    sport: 1,
    trad: 2,
    mixed: 3,
    top_rope: 4,
    unknown: 5
  }, validate: true

  enum :angle, {
    slab: 1,
    vertical: 2,
    slight_overhang: 3,
    overhang: 4,
    roof: 5,
    unknown_angle: 6
  }, validate: true

  scope :by_sector, -> (sector) { includes(crag: :sector).where(crags: { sector: sector }) }

  after_create :create_single_pitch, if: -> { previously_new_record? }
  after_create :sanitize_grade_and_set_standardized_grade
  before_commit :sanitize_grade_and_set_standardized_grade, on: :update, if: -> { :will_save_change_to_grade? }

  def format_name_and_grade_for_select
    "#{name} | #{grade}"
  end

  def pitch
    pitches.first
  end

  def grading_system
    country.grading_system
  end

  def create_single_pitch
    pitches.create(
      position: 1,
      length: height,
      pitch_grade: grade,
      angle: angle,
      bolts: 0 # TODO Figure where to get this data from
    )
  end
end
