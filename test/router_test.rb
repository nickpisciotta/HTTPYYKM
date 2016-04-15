require "simplecov"
SimepleCov.start
require "./lib/router"
require "minitest/autorun"
require "minitest/pride"

class RouterTest < Minitest::Test

  def test_response_by_path_for_hello
    router = Router.new
    h = {"Path" => "Path: /hello"}

    assert_equal "http/1.1 200 ok\r\n\r\nHello, World! 1", router.response_by_path(h)
  end

  def test_response_by_path_for_datetime
    router = Router.new
    h = {"Path" => "Path: /datetime"}

    assert_equal Time.now.strftime("%I:%M%p on %A, %B %d, %Y"), router.response_by_path(h)
  end

  def test_response_by_path_for_shutdown
    router = Router.new
    h = {"Path" => "Path: /shutdown"}

    assert_equal "http/1.1 200 ok\r\n\r\nTotal Request:", router.response_by_path(h)
  end

#   def test_response_by_path_for_debugging
#     router = Router.new
#     h = {"Verb"=>"Verb: GET",
#  "Path"=>"Path: /",
#  "Protocol"=>"Protocol: HTTP/1.1",
#  "Host"=>"Host: 127.0.0.1",
#  "Port"=>"Port: 9295",
#  "Origin"=>"Origin: 127.0.0.1",
#  "Accept"=>
#   "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"}
#
#     assert_equal
#      "<pre>Verb: GET
# Path: /
# Protocol: HTTP/1.1
# Host: 127.0.0.1
# Port: 9295
# Origin: 127.0.0.1
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
# </pre>", router.response_by_path(h)
#   end

  def test_response_by_path_word_search
    router = Router.new
    word = "dog"
    h = {"Path" => "Path: /word_search?param=#{word}"}

    assert_equal "#{word} is a known word.", router.response_by_path(h)
  end

  def test_response_by_path_word_search_include_cat
    router = Router.new
    word = "cat"
    h = {"Path" => "Path: /word_search?param=#{word}"}

    assert_equal "#{word} is a known word.", router.response_by_path(h)
  end

  def test_path_not_accounted_for
    router = Router.new

    h = {"Path" => "Path: /newpath"}

    assert_equal "http/1.1 200 ok\r\n\r\nNot valid path", router.response_by_path(h)
  end

  def test_path_start_game
    router = Router.new

    h = {"Path" => "Path: /start_game"}

    assert_equal "Good luck!", router.response_by_path(h)
  end

  def test_path_post_request_game
    router = Router.new

    h = {"Path" => "Path: /game", "Verb" => "Verb: POST"}

    assert_equal +"HTTP/1.1 303 See Other
Location: http://127.0.0.1:9295/game
\r", router.response_by_path(h)
  end

end
