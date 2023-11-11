class Cancel
  def initialize(user_input, registrations)
    @error = CourseErrorHelper.new
    @splitted_input = user_input
    @registrations = registrations
  end

  def call
    cancel
  end

  private

  attr_reader :splitted_input, :registrations, :error

  def cancel_registration?(registration_id)
    registrations.select { |registration| registration[:registration_id] == registration_id }.first
  end

  def cancel
    return error.data_error unless splitted_input.count == 2

    registration_id = splitted_input[1]
    searched_registration = cancel_registration?(registration_id)

    searched_registration[:is_canceled] = true

    puts "#{registration_id} CANCEL_ACCEPTED"
  end
end
