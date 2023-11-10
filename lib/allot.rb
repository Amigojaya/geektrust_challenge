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
    course_registrations = registrations.select { |registration| registration[:course_id] == course[:course_id] }

    return error.no_users_registered_error if course_registrations.empty?

    # Updating course when its alloted
    course[:is_alloted] = true

    course_registrations.each do |registration|
      puts "#{registration[:registration_id]} #{registration[:email]} #{registration[:course_id]} #{course[:title]} #{course[:instructor]} #{course[:date]} CONFIRMED"
    end
  end

  def course_has_min_employees(course)
  	registrations_count = registrations.select { |registration| registration[:course_id] == course[:course_id] }.count

    registrations_count >= course[:min_employees]
  end

  def is_course_valid?(course_id)
    course_offerings.select { |course| course[:course_id] == course_id }.first
  end

  def allot
    return error.data_error unless splitted_input.count == 2

    course_id = splitted_input[1]
    searched_course = is_course_valid?(course_id)

    return error.course_not_found_error if searched_course.nil?
    return error.course_already_canceled_error if searched_course[:is_cancelled]
    return error.min_employees_error unless course_has_min_employees(searched_course)

    print_register_users(searched_course)
  end
end
