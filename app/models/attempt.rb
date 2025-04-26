# frozen_string_litteral: true

class Attempt < ApplicationRecord
  belongs_to :climb

  validates :date, :status, presence: true

  enum :status, {
    onsight: 1,
    flash: 2,
    redpoint: 3,
    project: 4,
    retreated: 5,
    abandoned: 6
  }, validate: true
end
