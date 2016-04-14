# require "./lib/server"

class ParseRequest 
  attr_reader :hash


  def generate(request)
    format_hash(make_hash(request))
  end

  def make_hash(request)
    @hash = {}
    @hash["Verb"] = find_verb(request)
    @hash["Path"] = find_path(request)
    @hash["Protocol"] = find_protocol(request)
    @hash["Host"] = find_host(request)
    @hash["Port"] = find_port(request)
    @hash["Origin"] = find_origin(request)
    @hash["Accept"] = find_accept(request)
    @hash
  end

  def format_hash(hash)
    str = ""
    hash.each_value {|value| str << value + "\n" }
    "<pre>" + str  + "</pre>"
  end

  def find_verb(request)
    "Verb: #{request[0].split[0]}"
  end

  def find_path(request)
    "Path: #{request[0].split[1]}"
  end

  def find_protocol(request)
    "Protocol: #{request[0].split[2]}"
  end

  def find_host(request)
    host_string = request.find do |element|
      element.include?("Host")
    end
    "Host: #{host_string.split(":")[1].strip}"
  end

  def find_port(request)
    port_string = request.find do |element|
      element.include?("Host")
    end
    "Port: #{port_string.split(":")[2]}"
  end

  def find_origin(request)
    origin_string = request.find do |element|
      element.include?("Host")
    end
    "Origin: #{origin_string.split(":")[1].strip}"
  end

  def find_accept(request)
    accept_string = request.find do |element|
      element.include?("Accept:")
    end
    "Accept: #{accept_string.split(":")[1].strip}"
  end

end

# ch = CreateHash.new
# h = ["GET / HTTP/1.1", "Host: 127.0.0.1:9295", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
# # require 'pry';binding.pry
# puts ch.generate(h)
