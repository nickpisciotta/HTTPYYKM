require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require './lib/server'

class ServerTest < Minitest::Test

  def test_server_exists
    server = Server.new

    assert_equal Server, server.class
  end

  def test_if_faraday_connects
    skip
    conn = Faraday.new(:url => 'http://localhost:9295')
    response = conn.get("/hello")

  end

  # def test_split_string_method
  #   s = Server.new
  #   message = "Hello: there"
  #
  #   assert_equal "there", s.split_string(message, 1)
  # end

  def test_shutdown_returns_true_to_shutdown_server
    s = Server.new
    h = {"Path" => "Path: /shutdown"}

    assert_equal true, s.shutdown?(h)
  end

end
