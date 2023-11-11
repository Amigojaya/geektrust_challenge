require_relative 'course_schedule'
def main
  fileinput = ARGV[0]
  file = File.open(fileinput)

  CourseSchedule.new(file).call
end

main