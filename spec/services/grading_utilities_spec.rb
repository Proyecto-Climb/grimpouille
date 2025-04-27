# frozen_string_litteral: true

require 'rails_helper'

RSpec.describe GradingUtilities do
  describe 'YDS_REGEX' do
    context 'when it\'s a clean single digit grade' do
      let(:grade) { '5.8' }

      it 'matches the `clean_single_digit` matcher' do
        expect(test_yds_regex(grade)[:clean_single_digit]).to eq(grade)
      end
    end

    context 'when it\'s a single digit - grade' do
      let(:grade) { '5.8-' }

      it 'matches the `single_digit_minus` matcher' do
        expect(test_yds_regex(grade)[:single_digit_minus]).to eq(grade)
      end
    end

    context 'when it\'s a single digit + grade' do
      let(:grade) { '5.8+' }

      it 'matches the `single_digit_plus` matcher' do
        expect(test_yds_regex(grade)[:single_digit_plus]).to eq(grade)
      end
    end

    context 'when it\'s a clean double digit grade' do
      let(:grade) { '5.11a' }

      it 'matches the `clean_double_digit` matcher' do
        expect(test_yds_regex(grade)[:clean_double_digit]).to eq(grade)
      end
    end

    context 'when it\'s a double digit grade with NO letter' do
      let(:grade) { '5.11' }

      it 'matches the `double_digit_no_letter` matcher' do
        expect(test_yds_regex(grade)[:double_digit_no_letter]).to eq(grade)
      end
    end

    context 'when it\'s a double digit - grade' do
      let(:grade) { '5.11-' }

      it 'matches the `double_digit_minus` matcher' do
        expect(test_yds_regex(grade)[:double_digit_minus]).to eq(grade)
      end
    end

    context 'when it\'s a double digit + grade' do
      let(:grade) { '5.11+' }

      it 'matches the `double_digit_plus` matcher' do
        expect(test_yds_regex(grade)[:double_digit_plus]).to eq(grade)
      end
    end

    context 'when it\'s a double digit grade in between letters' do
      let(:grade) { '5.11a/b' }

      it 'matches the `double_digit_in_between_letters` matcher' do
        expect(test_yds_regex(grade)[:double_digit_in_between_letters]).to eq(grade)
      end
    end

    context 'when it\'s a double digit grade in between numbers' do
      let(:grade) { '5.11d/12a' }

      it 'matches the `double_digit_in_between_numbers` matcher' do
        expect(test_yds_regex(grade)[:double_digit_in_between_numbers]).to eq(grade)
      end
    end

    context 'when it\'s not a right format' do
      let(:grade) { 'gratallops' }

      it 'doesn\'t match at all' do
        expect(test_yds_regex(grade)).to be_nil
      end
    end
  end

  def test_yds_regex(grade)
    grade.match(GradingUtilities::YDS_REGEX)
  end
end
