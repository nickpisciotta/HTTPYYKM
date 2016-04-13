require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class ServerTest < Minitest::Test

  def test_server_exists
    skip
    server = Server.new
    server.tcp_server.close
    assert_equal Server, server.class
  end

  def test_server_response
    server = Server.new

    assert server.request_lines
  end

  def test_can_parse_request_lines
    server = Server.new

     \server.request
  end

end
