class Allot
  def initialize(user_input, course_offerings, registrations)
    @error = CourseErrorHelper.new
    @splitted_input = user_input
    @course_offerings = course_offerings
    @registrations = registrations
  end

  def call
    allot
  end

  private

  attr_reader :splitted_input, :course_offerings, :registrations, :error

  def print_register_users(course)
    course_registrations = registrations.select { |registration| registration[:course_id] == course[:course_id] && registration[:is_canceled] == false }
    status = course_registrations.count > course[:min_employees] ? 'CONFIRMED' : 'COURSE_CANCELED'

    course_registrations.sort_by { |registration| registration[:registration_id] }.each do |registration|
      puts "#{registration[:registration_id]} #{registration[:email]} #{registration[:course_id]} #{course[:title]} #{course[:instructor]} #{course[:date]} #{status}"
    end
  end

  def is_course_valid?(course_id)
    course_offerings.select { |course| course[:course_id] == course_id }.first
  end

  def allot
    return error.data_error unless splitted_input.count == 2

    course_id = splitted_input[1]
    searched_course = is_course_valid?(course_id)

    return error.course_not_found_error if searched_course.nil?
    return error.course_already_canceled_error if searched_course[:is_canceled]

    print_register_users(searched_course)
  end
end
