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

  describe '#create_single_pitch' do
    context 'when creating a new single pitch climbing_route' do
      let(:new_climbing_route) { build(:single_pitch_sport_climbing_route) }

      it 'creates its first pitch', :aggregate_failures do
        expect(new_climbing_route.pitch).to be_nil

        new_climbing_route.save
        pitch = new_climbing_route.pitch

        expect(pitch).to be_a(Pitch)
        expect(pitch.climbing_route).to be(new_climbing_route)
      end
    end

    context 'when updating a single pitch climbing_route' do
      let(:pitch) { instance.pitch }

      it 'does not create a new pitch', :aggregate_failures do
        expect(pitch).not_to be_nil

        instance.update!(name: 'Gossos: NO!')

        expect(instance.pitches.count).to eq(1)
        expect(pitch.id).to eq(instance.pitches.last.id)
      end
    end
  end

  describe '#pitch' do
    it 'returns the first pitch of the climbing_route' do
      expect(instance.pitch).to eq(instance.pitches.first)
    end
  end
end
