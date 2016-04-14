require 'socket'
require 'pry'
require './lib/parse_request'
require './lib/router'

class Server
  attr_reader :tcp_server, :request_lines

  def initialize
    @tcp_server = TCPServer.new(9295)
    @counter = 0
    @request_lines = []
    @ch = ParseRequest.new
    @router = Router.new
  end

  def start
    #parsed_request = {}
    #while and until loops
    loop do
      client = tcp_server.accept
      #client.gets
      while line = client.gets and !line.chomp.empty?
      @request_lines << line.chomp
      end
      @counter += 1
      parsed_request = @ch.make_hash(@request_lines)
      #parsed_request["Path"].include?("shutdown")
      #include?
      response = @router.response_by_path(parsed_request)
      client.puts response
      # client.puts @ch.generate(@request_lines)
      client.puts "#{@counter/2}"
      client.close
      #binding.pry
      break if response[0..13] == "Total Request:"
    end
  end
end
