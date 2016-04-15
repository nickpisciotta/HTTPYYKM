require "./lib/router"
require "minitest/autorun"
require "minitest/pride"

class RouterTest < Minitest::Test

  def test_response_by_path_for_hello
    router = Router.new
    h = {"Path" => "Path: /hello"}

    assert_equal "Hello, World! 1", router.response_by_path(h)
  end

  def test_response_by_path_for_datetime
    router = Router.new
    h = {"Path" => "Path: /datetime"}

    assert_equal Time.now.strftime("%I:%M%p on %A, %B %d, %Y"), router.response_by_path(h)
  end

  def test_response_by_path_for_shutdown
    router = Router.new
    h = {"Path" => "Path: /shutdown"}

    assert_equal "Total Request: 1", router.response_by_path(h)
  end

  def test_response_by_path_for_debugging
    router = Router.new
    h = {"Verb"=>"Verb: GET",
 "Path"=>"Path: /",
 "Protocol"=>"Protocol: HTTP/1.1",
 "Host"=>"Host: 127.0.0.1",
 "Port"=>"Port: 9295",
 "Origin"=>"Origin: 127.0.0.1",
 "Accept"=>
  "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"}

    assert_equal "<pre>Verb: GET
Path: /
Protocol: HTTP/1.1
Host: 127.0.0.1
Port: 9295
Origin: 127.0.0.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
</pre>", router.response_by_path(h)
  end

  def test_response_by_path_word_search
    router = Router.new
    word = "dog"
    h = {"Path" => "Path: /word_search?param=#{word}"}

    assert_equal "#{word} is a known word", router.response_by_path(h)
  end

  def test_response_by_path_word_search_include_cat
    router = Router.new
    word = "cat"
    h = {"Path" => "Path: /word_search?param=#{word}"}

    assert_equal "#{word} is a known word", router.response_by_path(h)
  end
end


# conn = Faraday.new(:url => 'http://localhost:9295') do |faraday|
#   faraday.request  :url_encoded             # form-encode POST params
#   faraday.response :logger                  # log requests to STDOUT
#   faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
