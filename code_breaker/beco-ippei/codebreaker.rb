require './lib/breaker'

breaker = Breaker.new 4.times.map {|e| rand 10 }
puts <<MSG
  Welcom to codebreaker !
  please input 4 numbers for try to break code.

  '+' is correct number and position.
  '-' is correct number but not match position.

  if code = '1234' and your input = '1256' ... result is '++'
  if code = '1234' and your input = '1340' ... result is '+--'

  good ruck !

MSG

i = 0
loop do
  print "please input (#{i})> "
  #TODO use readline
  input = gets.chomp

  if input == ''
    puts '' && next
  elsif %w[exit quit].include? input
    puts 'bye.' && exit
  elsif /^\d{4}$/ !~ input
    puts 'wrong inputs. please input 4 numbers'
    next
  end
  i += 1
  result = breaker.try input

  break if result == '++++'
  puts "  result ... [#{result}]. try again !"
end

puts <<MSG

  congratulation !!
  you broke a code.
  your answer [#{input}] is correct !

MSG

