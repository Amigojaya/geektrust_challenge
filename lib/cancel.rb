class Cancel
  def initialize(user_input, course_offerings)
    @error = CourseErrorHelper.new
    @splitted_input = user_input
    @course_offerings = course_offerings
  end

  def call
    cancel
  end

  private

  attr_reader :splitted_input, :course_offerings, :error

  def is_course_valid?(course_id)
    course_offerings.select { |course| course[:course_id] == course_id }.first
  end

  def cancel
    return error.data_error unless splitted_input.count == 2

    course_id = splitted_input[1]
    searched_course = is_course_valid?(course_id)

    return error.course_not_found_error if searched_course.nil?
    return puts 'CANCEL_REJECTED' if searched_course[:is_alloted]

    searched_course[:is_cancelled] = true

    puts "#{course_id} CANCEL_ACCEPTED"
  end
end
