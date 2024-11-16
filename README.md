# TCPChat

## Overview

TCPChat is a simple TCP chat server implemented in Ruby. It allows multiple clients to connect and communicate with each other in real-time. The server supports basic commands for starting the chat, displaying help information, and shutting down the server.

## Features

- Multi-client support: Multiple clients can connect and chat simultaneously.
- Server commands: The server can send messages to all clients and respond to user input.
- Client commands: Clients can send messages to others and disconnect gracefully.
- Help menu: Users can access a help menu for available commands.

## Requirements

- Ruby (version 2.0 or higher)
- A terminal or command prompt

## Installation

1. **Clone the repository** (if applicable):
   ```bash
   git clone https://github.com/markdormeus/TCPChat
   cd TCPChat
2. Install Ruby: Make sure you have Ruby installed on your machine. You can check if Ruby is installed by running:
   ```bash
   ruby -v

## Usage

1. Run the server:
   Open a terminal and navigate to the directory where tcp_chat_server.rb is located. Start the server by running:
   ```bash
   ruby tcp_chat_server.rb
2. Start the chat:
   In the server console, type start to begin listening for client connections.
3. Connect clients:
   For the client(s), open a terminal and navigate to the directory where tcp_chat_client.rb is located. Join the preexisting server by running:
   ```bash
   ruby tcp_chat_client.rb
   ```
   Alternatively, you can join from the same machine by running:
   ```bash
   telnet localhost 3001
   ```
   or
   ```bash
   nc localhost 3001
4. Chat:
   Clients can send messages to each other through the server. Type quit to disconnect from the chat.
5. Server commands:
   Type messages directly into the server console to broadcast them to all connected clients. Use q or quit in the server console to shut down the server.
6. Help command:
   Type help in the server console to see available commands.

## Example

1. Start the server:
   ```bash
   Waiting for clients...
2. Connect clients:
   ```bash
   New client connected: 8.8.8.8
3. Clients send messages:
   ```bash
   <username>: Hello everyone!
4. Server broadcasts messages:
   ```bash
   Server: Hello everyone!


