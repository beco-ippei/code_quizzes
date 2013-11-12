require 'em-websocket'
require './lib/breaker'
require 'json'
$breakers = {}

puts 'start websocket server ..'
EventMachine::WebSocket.start(host: '0.0.0.0', port: 3011) do |ws|
  ws.onopen do
    ans = 4.times.map {|e| rand 10 }.join
    $breakers[ws.__id__] = Breaker.new(ans)
    ws.send({msg: 'server opened & code initialized'}.to_json)
  end

  ws.onmessage do |msg|
    puts "received #{msg}"
    val = msg.split(':')

    case val[0]
    when 'msg'
      # do nothing
    when 'val'
      result = $breakers[ws.__id__].try val[1]
      ws.send({
        status: result.join,
        code: val[1],
      }.to_json)
    end
  end

  ws.onclose do
    puts "close socket"
  end
end
