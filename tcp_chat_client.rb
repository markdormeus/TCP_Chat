require 'socket'

puts "Enter the room's IP address:"
server_ip = gets.chomp

puts "Enter the username:"
username = gets.chomp

begin
    socket = TCPSocket.new(server_ip, 3001)

    Thread.new do
        while message = socket.gets
            puts message
        end
    end

    loop do 
        message = gets.chomp
        break if message.downcase == 'quit' || message.downcase == 'q'
        socket.puts "#{username}: #{message}"
    end
end
