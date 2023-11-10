require_relative 'helpers/course_error_helper'
require_relative 'lib/allot'
require_relative 'lib/cancel'
require_relative 'lib/register'
require_relative 'lib/course'

class CourseSchedule
  def initialize
    @course_offerings = []
    @registrations = []
  end

  attr_reader :splited_input, :course_offerings, :registrations

  def main_method
    puts "\nSelect One Option to continue - ADD-COURSE-OFFERING , REGISTER , ALLOT , CANCEL"

    user_input = gets.chomp
    @splited_input = begin
      user_input.split(' ')
    rescue StandardError
      []
    end
    method_name = splited_input.first

    case method_name
    when 'ADD-COURSE-OFFERING'
      Course.new(splited_input, course_offerings).call
    when 'REGISTER'
      Register.new(splited_input, course_offerings, registrations).call
    when 'ALLOT'
      Allot.new(splited_input, course_offerings, registrations).call
    when 'CANCEL'
      Cancel.new(splited_input, course_offerings).call
    end

    main_method unless method_name&.upcase == 'EXIT'
  end
end

CourseSchedule.new.main_method
