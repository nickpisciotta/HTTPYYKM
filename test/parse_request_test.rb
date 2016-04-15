require "simplecov"
SimepleCov.start
require "./lib/parse_request"
require "minitest/autorun"
require "minitest/pride"

class ParseRequestTest < Minitest::Test

  def test_class_exists
    hash = ParseRequest.new

    assert_equal ParseRequest, hash.class
  end


  def test_find_verb_from_request
    parsed = ParseRequest.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]

    assert_equal "Verb: GET", parsed.find_verb(input)
  end

  def test_find_path_from_request
    parsed = ParseRequest.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]

    assert_equal "Path: /", parsed.find_path(input)
  end

  def test_find_protocol_from_request
    parsed = ParseRequest.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    assert_equal "Protocol: HTTP/1.1", parsed.find_protocol(input)
  end

  def test_find_host_from_request
    parsed = ParseRequest.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    assert_equal "Host: 127.0.0.1", parsed.find_host(input)
  end

  def test_find_port_from_request
    parsed = ParseRequest.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    assert_equal "Port: 9295", parsed.find_port(input)
  end

  def test_find_origin_from_request
    parsed = ParseRequest.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    assert_equal "Origin: 127.0.0.1", parsed.find_origin(input)
  end

  def test_find_accept_from_request
    parsed = ParseRequest.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    assert_equal "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", parsed.find_accept(input)
  end

  def test_displays_request_as_response
    parsed = ParseRequest.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    hash = parsed.make_hash(input)
    assert_equal "Verb: GET", hash["Verb"]
  end


  def test_format_hash_returns_formatted_hash
    parsed = ParseRequest.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    hash = parsed.make_hash(input)
    hash_formatted = parsed.format_hash(hash)
    assert_equal  String, hash_formatted.class
  end

end
