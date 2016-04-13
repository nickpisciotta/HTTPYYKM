require 'socket'
require 'pry'
require './lib/create_hash'

class Server
  attr_reader :tcp_server, :request_lines

  def initialize
    @tcp_server = TCPServer.new(9295)
    @counter = 0
    @request_lines = []
    @ch = CreateHash.new
  end

  def start
    loop do
      client = tcp_server.accept
      #client.gets
      while line = client.gets and !line.chomp.empty?
      @request_lines << line.chomp
      end
      @counter += 1
      client.puts @ch.generate(@request_lines)
      client.puts "#{@counter/2}"
      client.close
      #binding.pry
    end
  end
end
