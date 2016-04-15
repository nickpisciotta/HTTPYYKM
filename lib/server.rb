require 'socket'
require 'pry'
require './lib/parse_request'
require './lib/router'
require 'pp'

class Server
  attr_reader :tcp_server, :request_lines

  def initialize
    @tcp_server = TCPServer.new(9295)
    @counter = 0
    @parsed = ParseRequest.new
    @router = Router.new
  end

  def start
    loop do
      client = @tcp_server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
      end
      @counter += 1
      parsed_request = @parsed.make_hash(request_lines)
      read_content(parsed_request)
      if shutdown?(parsed_request)
        client.puts "HTTP/1.1 200 ok"
        client.puts "\r\n"
        client.puts "Total Request: #{@counter}"
        client.close
        @tcp_server.close
      else
        unless @content_l.nil?
          body_data = client.read(@content_l)
          @router.guess = body_data.to_i
        end
        response = @router.response_by_path(parsed_request)
        client.puts response
        client.close
      end
    end
  end

  def shutdown?(parsed_request)
    parsed_request["Path"] == "Path: /shutdown"
  end

  def read_content(parsed_request)
    if parsed_request["Content-Length"]
      # binding.pry
      @content_l = split_string(parsed_request["Content-Length"], 1).to_i
    else
      @content_l = nil
    end
  end

  def split_string(string, index)
    string.split(":")[index].strip
  end

end
