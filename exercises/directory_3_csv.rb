# this version uses the CSV class to read/write from/to .csv files instead of using the File class
require 'csv' 
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
  name = STDIN.gets.chomp
  while !name.empty? do
    add_students(name)
    puts "Now we have #{@students.count} students"
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

# uses class CSV instead of File and do..end block
def save_students
  puts "Enter filename to save to (please include the .csv at the end):"
  filename = gets.chomp
  CSV.open(filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      file << student_data # means we no longer need to do .join(",")
    end
  end
  puts "Students saved to file '#{filename}'"
end

# uses class CSV instead of File and do..end block
def load_students(filename = nil)
  if filename == nil
    puts "Enter filename to load (please include the .csv at the end)"
    filename = gets.chomp
  end
  CSV.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort = line # no longer need to do .chomp.split(",")
      add_students(name, cohort)
    end
  end
  puts "**Loaded students from '#{filename}'**"
end

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
