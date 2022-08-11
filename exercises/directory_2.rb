# wasn't originally intending to have this under git version control, hence a lot of old code commented out
 @students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save list"
  puts "4. Load list"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_students(name)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def add_students(name, cohort = "TBC")
  @students << {name: name, cohort: cohort.to_sym}
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

# def save_students
#   file = File.open("students.csv", "w")
#   @students.each do |student|
#     student_data = [student[:name], student[:cohort]]
#     csv_line = student_data.join(",")
#     file.puts csv_line
#   end
#   file.close
#   puts "Students saved to file."
# end

# # this method version allows user to specify filename to save to
# def save_students
#   puts "Enter filename to save to (please include the .csv at the end):"
#   filename = gets.chomp
#   file = File.open(filename, "w")
#   @students.each do |student|
#     student_data = [student[:name], student[:cohort]]
#     csv_line = student_data.join(",")
#     file.puts csv_line
#   end
#   file.close
#   puts "Students saved to file '#{filename}'"
# end

# this method version allows user to specify filename to save to
# uses do..end block to open and close file
def save_students
  puts "Enter filename to save to (please include the .csv at the end):"
  filename = gets.chomp
  File.open(filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
  puts "Students saved to file '#{filename}'"
end

# def load_students(filename = "students.csv")
#   file = File.open(filename, "r")
#   file.readlines.each do |line|
#     name, cohort = line.chomp.split(",")
#     @students << {name: name, cohort: cohort.to_sym}
#   end
#   file.close
# end

# def load_students(filename = nil)
#   if filename == nil
#     puts "Enter filename to load (please include the .csv at the end)"
#     filename = gets.chomp
#   end
#   file = File.open(filename, "r")
#   file.readlines.each do |line|
#     name, cohort = line.chomp.split(",")
#     add_students(name, cohort)
#   end
#   file.close
#   puts "**Loaded students from '#{filename}'**"
# end

# uses do..end block to open and close file
def load_students(filename = nil)
  if filename == nil
    puts "Enter filename to load (please include the .csv at the end)"
    filename = gets.chomp
  end
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      add_students(name, cohort)
    end
  end
  puts "**Loaded students from '#{filename}'**"
end

# def try_load_students
#   filename = ARGV.first # first argument from the command line
#   return if filename.nil? # exit method if no ARGV value(s) given
#   if File.exist?(filename)
#     load_students(filename)
#     puts "Loaded #{@students.count} from #{filename}"
#   else
#     puts "Sorry, #{filename} doesn't exist."
#     exit
#   end
# end

# # this loads students.csv if no file given at command line
# def try_load_students
#   filename = ARGV.first # first argument from the command line
#   if filename.nil?
#     load_students("students.csv")
#     puts "**No file request detected - loaded default file 'students.csv'**"
#   else
#     if File.exist?(filename)
#       load_students(filename)
#       puts "Loaded #{@students.count} from #{filename}"
#     else
#       puts "Sorry, #{filename} doesn't exist."
#       exit
#     end
#   end
# end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil?    
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end  
end

try_load_students
interactive_menu
