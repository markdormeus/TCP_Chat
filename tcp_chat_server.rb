require 'socket'

class ChatServer
  def start_menu
    puts "       =[                     TCPChat v1.0.0                    ]"
    puts "+ -- --=[           A simple TCP chat server in Ruby            ]"
    puts "+ -- --=[ Type 'q' or 'quit' in the server console to shut down ]"
    puts "+ -- --=[         Clients can type 'quit' to disconnect.        ]"
    puts "TCPChat tip: Use 'help' to see available commands"
    h_input = gets.chomp
    case h_input 
    when "start"
        run
    when "help"
        puts "Available commands:"
        puts "start - Starts a server on port 3001 for two-way communication"
        puts "help - Show this help message"
        puts "q/quit - Exit TCPChat"
        start_menu
    when "q", "quit"
        puts "Exiting..."
        exit
    else 
        start_menu
    end
  end
  def initialize(port)
    @server = TCPServer.new('0.0.0.0', port)
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
    client_address = client.peeraddr[3]
    client.puts "Welcome to the chat! Type 'quit' to exit."
    
    loop do
      msg = client.gets
      break if msg.nil? || msg.downcase.strip == 'quit' || msg.downcase.strip == 'q'
      
      # Broadcast message from this client
      broadcast("#{msg}", client)
    end
  rescue IOError => e
    puts "Error handling client: #{e.message}"
  ensure
    @clients.delete(client)
    client.close rescue nil  # Ignore errors on close
    puts "Client disconnected: #{client_address}"
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
      break if input.downcase == 'quit' || input.downcase == 'q'   # Allow server shutdown 
      
      # Broadcast the server message to all clients
      broadcast("Server: #{input}", nil)
    end
  end
end

server = ChatServer.new(3001)
server.start_menu