require "./lib/create_hash"
require "minitest/autorun"
require "minitest/pride"

class CreateHashTest < Minitest::Test

  def test_class_exists
    hash = CreateHash.new

    assert_equal CreateHash, hash.class
  end


  def test_find_verb_from_request
    ch = CreateHash.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]

    assert_equal "Verb: GET", ch.find_verb(input)
  end

  def test_find_path_from_request
    ch = CreateHash.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]

    assert_equal "Path: /", ch.find_path(input)
  end

  def test_find_protocol_from_request
    ch = CreateHash.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    assert_equal "Protocol: HTTP/1.1", ch.find_protocol(input)
  end

  def test_find_host_from_request
    ch = CreateHash.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    assert_equal "Host: 127.0.0.1", ch.find_host(input)
  end

  def test_find_port_from_request
    ch = CreateHash.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    assert_equal "Port: 9295", ch.find_port(input)
  end

  def test_find_origin_from_request
    ch = CreateHash.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    assert_equal "Origin: 127.0.0.1", ch.find_origin(input)
  end

  def test_find_accept_from_request
    ch = CreateHash.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    assert_equal "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", ch.find_accept(input)
  end

  def test_displays_request_as_response
    ch = CreateHash.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    hash = ch.make_hash(input)
    assert_equal "Verb: GET", hash["Verb"]
  end


  def test_format_hash_returns_formatted_hash
    ch = CreateHash.new
    input = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    hash = ch.make_hash(input)
    fh = ch.format_hash(hash)
    assert_equal  String, fh.class
  end
  
end
