require './lib/breaker'
require 'readline'

ans = 4.times.map {|e| rand 10 }.join
breaker = Breaker.new(ans)
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
  input = Readline::readline "please input (#{i})> "

  if input == ''
    puts '' && next
  elsif ['exit', 'quit', nil].include? input
    puts 'bye.'
    exit
  elsif input == 'giveup'
    puts "  code was [#{ans}]  bye."
    exit
  elsif /^\d{4}$/ !~ input
    puts 'wrong inputs. please input 4 numbers'
    next
  end
  i += 1
  result = breaker.try(input).join
  Readline::HISTORY.push input

  break if result == '++++'
  puts "        result ... [#{result}]. try again !"
end

require 'active_support/core_ext/integer/inflections'
puts <<MSG

  congratulation !!
  you broke a code.
  your #{i.ordinalize} answer [#{ans}] is correct !

MSG

