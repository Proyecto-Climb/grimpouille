# frozen_string_litteral: true

require 'rails_helper'

RSpec.describe ClimbingRoute, type: :model do
  let(:instance) { create(:single_pitch_sport_climbing_route) }

  describe '#format_name_and_grade_for_select' do
    it 'returns a formatted String of the name and the grade' do
      expected = "#{instance.name} | #{instance.grade}"
      actual = instance.format_name_and_grade_for_select

      expect(actual).to eq(expected)
    end
  end

  describe '#pitch' do
    before do
      pitch = Pitch.new(
        position: 2,
        length: 20,
        pitch_grade: instance.grade,
        angle: 90,
        bolts: 7
      )
      pitch.climbing_route = instance
    end

    it 'returns the first pitch of the climbing_route' do
      expect(instance.pitch).to eq(instance.pitches.first)
    end
  end
end
