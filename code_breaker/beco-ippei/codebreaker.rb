require './lib/breaker'

breaker = Breaker.new 1234

p breaker.try(1245)

