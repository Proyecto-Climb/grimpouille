require 'rails_helper'

RSpec.describe GradesConversionService do
  let(:instance) { create(:single_pitch_sport_climbing_route) }

  describe '#sanitize_yds_grade' do
    subject { instance.sanitize_yds_grade(grade) }

    context 'when the grade is clean' do
      let(:grade) { instance.grade }

      it 'leaves the grade unchanged' do
        actual = subject
        expect(actual).to eq(grade)
      end
    end

    context 'when it\'s a single digit - grade' do
      let(:grade) { '5.8-' }

      it 'returns the grade without the minus sign' do
        expect(subject).to eq('5.8')
      end
    end

    context 'when it\'s a single digit + grade' do
      let(:grade) { '5.8+' }

      it 'returns the following grade' do
        expect(subject).to eq('5.9')
      end
    end

    context 'when it\'s a clean double digit grade' do
      let(:grade) { '5.11a' }

      it 'returns the grade' do
        expect(subject).to eq(grade)
      end
    end

    context 'when it\'s a double digit grade with NO letter' do
      let(:grade) { '5.11' }

      it 'returns the grade with the letter `c` added' do
        expect(subject).to eq('5.11c')
      end
    end

    context 'when it\'s a double digit - grade' do
      let(:grade) { '5.11-' }

      it 'returns the grade with the letter `a` added' do
        expect(subject).to eq('5.11a')
      end
    end

    context 'when it\'s a double digit + grade' do
      let(:grade) { '5.11+' }

      it 'returns the grade with the letter `d` added' do
        expect(subject).to eq('5.11d')
      end
    end

    context 'when it\'s a double digit grade in between letters' do
      let(:grade) { '5.11a/b' }

      it 'returns the higher grade' do
        expect(subject).to eq('5.11b')
      end
    end

    context 'when it\'s a double digit grade in between numbers' do
      let(:grade) { '5.11d/12a' }

      it 'returns the higher grade' do
        expect(subject).to eq('5.12a')
      end
    end

    context 'when it\'s not a right format' do
      let(:grade) { 'gratallops' }

      it 'returns `5.0`' do
        expect(subject).to eq('5.0')
      end
    end
  end

  describe '#sanitize_grade_and_set_standardized_grade' do
    subject { instance.sanitize_grade_and_set_standardized_grade }

    let(:instance) { build(:climbing_route, :with_all_associations, grade: '5.11a') }

    context 'when it is a YDS grade' do
      it 'sets the value for the `standardized_grade` attribute from the grade' do
        subject
        expect(instance.standardized_grade).to eq(14)
      end
    end
  end

  describe '#sanitize_single_digit_plus' do
    subject { instance.sanitize_single_digit_plus(grade) }

    let(:grade) { instance.grade }

    context 'when the grade is 5.9+' do
      let(:instance) { build(:climbing_route, grade: '5.9+') }

      it 'returns 5.10a', :aggregate_failures do
        allow(instance).to receive(:convert_last_digit).with(9).and_call_original
        expect(subject).to eq('5.10a')
      end
    end

    context 'when the grade is 5.8+' do
      let(:instance) { build(:climbing_route, grade: '5.8+') }

      it 'returns 5.9', :aggregate_failures do
        allow(instance).to receive(:convert_last_digit).with(8).and_call_original
        expect(subject).to eq('5.9')
      end
    end
  end
end
