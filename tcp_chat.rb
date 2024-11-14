require 'socket'

class ChatServer
  def initialize(port)
    @server = TCPServer.new(port)
    @clients = []
    puts "Chat server started on port #{port}"
    puts Time.now
  end

  def run
    puts "Waiting for clients..."
    Thread.new { listen_for_server_input }  # Start a thread to listen for server input

    loop do
      client = @server.accept
      @clients << client
      puts "New client connected: #{client.peeraddr[3]}"
      Thread.new { handle_client(client) }
    end
  end

  private

  def handle_client(client)
    client.puts "Welcome to the chat! Type 'quit' to exit."
    
    loop do
      msg = client.gets.chomp
      break if msg.downcase == 'q'
      
      # Broadcast message from this client
      broadcast("#{client.peeraddr[3]}: #{msg}", client)
    end
    @clients.delete(client)
    client.close
    puts "Client disconnected: #{client.peeraddr[3]}"
  end

  def broadcast(msg, sender)
    puts msg  # Server-side logging
    @clients.each do |client|
      client.puts msg unless client == sender
    end 
  end

  def listen_for_server_input
    loop do
      input = gets.chomp  # Get input from the server console
      break if input.downcase == 'exit'  # Allow server shutdown with 'exit'
      
      # Broadcast the server message to all clients
      broadcast("Server: #{input}", nil)
    end
  end
end

ChatServer.new(3001).run