class CourseErrorHelper
  def data_error
    puts 'INPUT_DATA_ERROR'
  end

  def course_full_error
    puts 'COURSE_FULL_ERROR'
  end

  def already_exists(name)
    puts "#{name.upcase}_ALREADY_EXISTS_ERROR"
  end

  def course_not_found_error
    puts 'COURSE_NOT_FOUND_ERROR'
  end

  def course_already_canceled_error
    puts 'COURSE_ALREADY_CANCELED_ERROR'
  end
end
