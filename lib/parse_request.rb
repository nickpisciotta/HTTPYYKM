
class ParseRequest
  attr_reader :hash

  def make_hash(request)
    hash = {}
    hash["Verb"] = find_verb(request)
    hash["Path"] = find_path(request)
    hash["Protocol"] = find_protocol(request)
    hash["Host"] = find_host(request)
    hash["Port"] = find_port(request)
    hash["Origin"] = find_origin(request)
    hash["Accept"] = find_accept(request)
    hash["Content-Length"] = find_content(request) unless find_content(request).nil?
    hash
  end

  def format_hash(hash)
    hash_to_string = ""
    hash.each_value {|value| hash_to_string << value + "\n" }
    "<pre>" + hash_to_string + "</pre>"
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
    "Host: #{parse_string(host_string, 1)}"
  end

  def find_port(request)
    port_string = request.find do |element|
      element.include?("Host")
    end
    "Port: #{parse_string(port_string, 2)}"
  end

  def find_origin(request)
    origin_string = request.find do |element|
      element.include?("Host")
    end
    "Origin: #{parse_string(origin_string, 1)}"
  end

  def find_accept(request)
    accept_string = request.find do |element|
      element.include?("Accept:")
    end
    "Accept: #{parse_string(accept_string, 1)}"
  end

  def parse_string(string, index)
    string.split(":")[index].strip
  end

  def find_content(request)
    content_string = request.find do |element|
      element.include?("Content-Length:")
    end
    if content_string == nil
      nil
    else
    "Content-Length: #{parse_string(content_string, 1)}"
    end
  end

end
