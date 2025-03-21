# frozen_string_literal: true

module GradesConversionService
  YDS = {
    '5.0' => 0,
    '5.1' => 1,
    '5.2' => 2,
    '5.3' => 3,
    '5.4' => 4,
    '5.5' => 5,
    '5.6' => 6,
    '5.7' => 7,
    '5.8' => 8,
    '5.9' => 9,
    '5.10a' => 10,
    '5.10b' => 11,
    '5.10c' => 12,
    '5.10d' => 13,
    '5.11a' => 14,
    '5.11b' => 15,
    '5.11c' => 16,
    '5.11d' => 17,
    '5.12a' => 18,
    '5.12b' => 19,
    '5.12c' => 20,
    '5.12d' => 21,
    '5.13a' => 22,
    '5.13b' => 23,
    '5.13c' => 24,
    '5.13d' => 25,
    '5.14a' => 26,
    '5.14b' => 27,
    '5.14c' => 28,
    '5.14d' => 29,
    '5.15a' => 30,
    '5.15b' => 31,
    '5.15c' => 32,
    '5.15d' => 33,
    '5.16a' => 34
  }

  EU_SYSTEM = {
    '-2' => 0,
    '-1' => 1,
    '0' => 2,
    '1' => 3,
    '2' => 4,
    '3' => 5,
    '3+' => 6,
    '4' => 7,
    '4+' => 8,
    '5' => 9,
    '5+' => 10,
    '6a' => 11,
    '6a+' => 12,
    '6b' => 13,
    '6b+' => 14,
    '6c' => 15,
    '6c+' => 16,
    '7a' => 17,
    '7a+' => 18,
    '7b' => 19,
    '7b+' => 20,
    '7c' => 21,
    '7c+' => 22,
    '8a' => 23,
    '8a+' => 24,
    '8b' => 25,
    '8b+' => 26,
    '8c' => 27,
    '8c+' => 28,
    '9a' => 29,
    '9a+' => 30,
    '9b' => 31,
    '9b+' => 32,
    '9c' => 33,
    '9c+' => 34
  }

  YDS_REGEX = /
      \A(?<double_digit_in_between_letters>5\.\d{2}[a-d]\/[a-d])|
      (?<double_digit_in_between_numbers>5\.\d{2}[a-d]\/\d{2}[a-d])|
      (?<clean_double_digit>5\.\d{2}[a-d])|
      (?<double_digit_no_letter>5\.\d{2})|
      (?<double_digit_plus>5\.\d{2}\+)|
      (?<double_digit_minus>5\.\d{2}-)|
      (?<single_digit_plus>5\.\d\+)|
      (?<single_digit_minus>5\.\d-)|
      (?<clean_single_digit>5\.\d{1})\z
    /ix

  def sanitize_yds_grade(grade)
    match_data = GradesConversionService::YDS_REGEX.match(grade)

    if match_data
      if match_data[:double_digit_in_between_letters]
        grade.gsub(/[a-c]\//, '')
      elsif match_data[:double_digit_in_between_numbers]
        grade.gsub(/\d{2}[a-d]\//, '')
      elsif match_data[:double_digit_no_letter]
        "#{match_data[:double_digit_no_letter]} 'c'"
      elsif match_data[:double_digit_plus]
        grade.gsub('+', 'd')
      elsif match_data[:double_digit_minus]
        grade.gsub('-', 'a')
      elsif match_data[:single_digit_plus]
        sanitize_single_digit_plus(grade)
      elsif match_data[:single_digit_minus]
        grade.gsub('-', '')
      elsif match_data[:clean_double_digit] || match_data[:clean_single_digit]
        match_data[:clean_double_digit] || match_data[:clean_single_digit]
      end
    else
      '5.0'
    end
  end

  def sanitize_single_digit_plus(grade)
    split_grade = grade.gsub('+', '').split('.')
    split_grade[-1] = convert_last_digit(split_grade[-1].to_i)
    split_grade.join('.')
  end

  def convert_last_digit(digit)
    digit == 9 ? '10a' : (digit + 1).to_s
  end
end
