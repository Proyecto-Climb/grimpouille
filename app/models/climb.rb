# frozen_string_litteral: true

class Climb < ApplicationRecord
  belongs_to :route
  belongs_to :climber, class_name: 'User', foreign_key: 'climber_id'

  enum status: {
    onsight: 1,
    flash: 2,
    redpoint: 3,
    project: 4,
    retreated: 5,
    abandoned: 6
  }
end
