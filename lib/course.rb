class Course
  def initialize(user_input, course_offerings)
    @error = CourseErrorHelper.new
    @splitted_input = user_input
    @course_offerings = course_offerings
  end

  def call
    add_course_offering
  end

  attr_reader :course_offerings, :splitted_input, :error

  def course_id(course_offering)
    "OFFERING-#{course_offering[1]}-#{course_offering[2]}"
  end

  def course_details(course_offering)
    {
      title: course_offering[1],
      instructor: course_offering[2],
      date: course_offering[3],
      min_employees: course_offering[4].to_i,
      max_employees: course_offering[5].to_i,
      course_id: course_id(course_offering),
      is_alloted: false,
      is_cancelled: false
    }
  end

  def is_course_exists?(course_id)
    course_offerings.select { |course| course[:course_id] == course_id }.any?
  end

  def add_course_offering
    return error.data_error unless splitted_input.count == 6

    course_details = course_details(splitted_input)

    return already_exists('course') if is_course_exists?(course_details[:course_id])

    course_offerings << course_details

    puts course_details[:course_id]
  end
end
