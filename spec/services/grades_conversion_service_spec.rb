require 'rails_helper'

RSpec.describe GradesConversionService do
  # subject { instance.sanitize_yds_grade }

  let(:instance) { create(:single_pitch_sport_climbing_route) }

  describe '#sanitize_yds_grade' do
    context 'when the grade is clean' do
      it 'leaves the grade unchanged' do
        initial_grade = instance.grade

        actual = instance.sanitize_yds_grade(initial_grade)
        expect(actual).to eq(initial_grade)
      end
    end

    context 'when the grade is clean' do
      it 'leaves the grade unchanged' do
        initial_grade = instance.grade

        actual = instance.sanitize_yds_grade(initial_grade)
        expect(actual).to eq(initial_grade)
      end
    end
  end
end
