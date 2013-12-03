require 'socket'

server = TCPServer.new 8080

loop do
  client = server.accept

  request_line = client.gets

  loop do
     break if client.gets == "\r\n"
  end

  _, path, _ = request_line.split(" ")
  path = path[1..-1]

  if File.exists?(path)
    content = File.read(path)

    client.write "HTTP/1.1 200 OK\r\n"
    client.write "Content-Type: text/plain\r\n"
  else
    content = "<h1>404 Not Found</h1>"

    client.write "HTTP/1.1 404 Not Found\r\n"
    client.write "Content-Type: text/html\r\n"
  end

  client.write "Content-Length: #{content.bytesize}\r\n"
  client.write "\r\n"
  client.write content

  client.close
end
