require_relative 'helpers/course_error_helper'
require_relative 'lib/allot'
require_relative 'lib/cancel'
require_relative 'lib/register'
require_relative 'lib/course'

class CourseSchedule
	def initialize(file)
		@file = file
    @course_offerings = []
    @registrations = []
  end

  attr_reader :splited_input, :course_offerings, :registrations, :file

	def call
	  file.readlines.each do |line|
			splited_input = line.split(' ')
		  method_name = splited_input.first

		  case method_name
		  when 'ADD-COURSE-OFFERING'
		    Course.new(splited_input, course_offerings).call
		  when 'REGISTER'
		    Register.new(splited_input, course_offerings, registrations).call
		  when 'ALLOT'
		    Allot.new(splited_input, course_offerings, registrations).call
		  when 'CANCEL'
		    Cancel.new(splited_input, registrations).call
		  end
		end
	end
end