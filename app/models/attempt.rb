# frozen_string_litteral: true

class Attempt < ApplicationRecord
  belongs_to :climb

  enum :status, {
    onsight: 1,
    flash: 2,
    redpoint: 3,
    project: 4,
    retreated: 5,
    abandoned: 6
  }
end
