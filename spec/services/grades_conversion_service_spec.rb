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

    context 'when it\'s a single digit - grade' do
      let(:grade) { '5.8-' }

      it 'returns the grade without the minus sign' do
        expect(instance.sanitize_yds_grade(grade)).to eq('5.8')
      end
    end

    context 'when it\'s a single digit + grade' do
      let(:grade) { '5.8+' }

      it 'returns the following grade' do
        expect(instance.sanitize_yds_grade(grade)).to eq('5.9')
      end
    end

    context 'when it\'s a clean double digit grade' do
      let(:grade) { '5.11a' }

      it 'returns the grade' do
        expect(instance.sanitize_yds_grade(grade)).to eq(grade)
      end
    end

    context 'when it\'s a double digit grade with NO letter' do
      let(:grade) { '5.11' }

      it 'returns the grade with the letter `c` added' do
        expect(instance.sanitize_yds_grade(grade)).to eq('5.11c')
      end
    end

    context 'when it\'s a double digit - grade' do
      let(:grade) { '5.11-' }

      it 'returns the grade with the letter `a` added' do
        expect(instance.sanitize_yds_grade(grade)).to eq('5.11a')
      end
    end

    context 'when it\'s a double digit + grade' do
      let(:grade) { '5.11+' }

      it 'returns the grade with the letter `d` added' do
        expect(instance.sanitize_yds_grade(grade)).to eq('5.11d')
      end
    end

    context 'when it\'s a double digit grade in between letters' do
      let(:grade) { '5.11a/b' }

      it 'returns the higher grade' do
        expect(instance.sanitize_yds_grade(grade)).to eq('5.11b')
      end
    end

    context 'when it\'s a double digit grade in between numbers' do
      let(:grade) { '5.11d/12a' }

      it 'returns the higher grade' do
        expect(instance.sanitize_yds_grade(grade)).to eq('5.12a')
      end
    end

    context 'when it\'s not a right format' do
      let(:grade) { 'gratallops' }

      it 'returns `5.0`' do
        expect(instance.sanitize_yds_grade(grade)).to eq('5.0')
      end
    end
  end
end
