require 'socket'

server = TCPServer.new 8080

loop do
  client = server.accept

  loop do
     break if client.gets == "\r\n"
  end

  content = "The time is #{Time.now}\n"

  client.write "HTTP/1.1 200 OK\r\n"
  client.write "Content-Type: text/html\r\n"
  client.write "Content-Length: #{content.bytesize}\r\n"
  client.write "\r\n"
  client.write content

  client.close
end
