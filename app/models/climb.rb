# frozen_string_litteral: true

class Climb < ApplicationRecord
  belongs_to :route
  belongs_to :climber, class_name: 'User', foreign_key: 'climber_id'
end
