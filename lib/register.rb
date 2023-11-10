class Register
  def initialize(user_input, course_offerings, registrations)
    @error = CourseErrorHelper.new
    @splitted_input = user_input
    @course_offerings = course_offerings
    @registrations = registrations
  end

  def call
    register
  end

  private

  attr_reader :registrations, :course_offerings, :splitted_input, :error

  def is_email_valid?(email)
    email_pattern = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i
    email =~ email_pattern
  end

  def is_course_valid?(course_id)
    course_offerings.select { |course| course[:course_id] == course_id }.first
  end

  def registration_id(email, title)
    user_name = email.split('@').first

    "REG-COURSE-#{user_name}-#{title}"
  end

  def course_has_limit(course)
    registrations_count = registrations.select { |registration| registration[:course_id] == course[:course_id] }.count

    registrations_count >= course[:max_employees]
  end

  def is_user_already_exists(email, course_id)
    registrations.select { |registration| registration[:email] == email && registration[:course_id] == course_id }.any?
  end

  def registration_data(registration)
    email = registration[1]
    course_id = registration[2]
    searched_course = is_course_valid?(course_id)

    return error.data_error unless is_email_valid?(email)
    return error.data_error if searched_course.nil?
    return error.course_already_canceled_error if searched_course[:is_cancelled]
    return error.already_exists('user') if is_user_already_exists(email, course_id)
    return error.course_full_error if course_has_limit(searched_course)

    {
      email: email,
      course_id: course_id,
      registration_id: registration_id(email, searched_course[:title])
    }
  end

  def register
    return error.data_error unless splitted_input.count == 3

    registration = registration_data(splitted_input)
    return unless registration.is_a?(Hash)

    registrations << registration

    puts "#{registration[:registration_id]} ACCEPTED"
  end
end
