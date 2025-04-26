# frozen_string_literal: true

module GradesConversionService
  include GradingUtilities

  def sanitize_grade_and_set_standardized_grade
    case country.grading_system
    when 'YDS'
      sanitized_grade = sanitize_yds_grade(grade)
      self.standardized_grade = YDS[sanitized_grade]
    when 'EU'
      # TODO
      sanitized_grade = grade
    end

    self.grade = sanitized_grade
    save!
  end

  def sanitize_yds_grade(grade)
    match_data = YDS_REGEX.match(grade)

    if match_data
      if match_data[:double_digit_in_between_letters]
        grade.gsub(/[a-c]\//, '')
      elsif match_data[:double_digit_in_between_numbers]
        grade.gsub(/\d{2}[a-d]\//, '')
      elsif match_data[:double_digit_no_letter]
        "#{match_data[:double_digit_no_letter]}c"
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
