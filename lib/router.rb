require './lib/parse_request'
require 'pry'

class Router

  def response_by_path(hash)
    @counter ||= 0
    #binding.pry
    #case statement
    if hash["Path"] == "Path: /"
      print_debugging(hash)
    elsif hash["Path"] == "Path: /hello"
      @counter += 1
      print_hello
    elsif hash["Path"] == "Path: /datetime"
      print_date
    elsif hash["Path"].include?("/word_search")
      print_word_search
    elsif hash["Path"] == "Path: /shutdown"
      @counter += 1
      print_shutdown
    end
  end

  def print_debugging(hash)
    ch = ParseRequest.new
    ch.format_hash(hash)
  end

  def print_hello
    "Hello, World! #{@counter}"
  end

  def print_date
    Time.now.strftime("%I:%M%p on %A, %B %d, %Y")
  end

  def print_shutdown
    "Total Request: #{@counter}"
  end

  def print_word_search
    #Need to take param word
    #See if word exists within dictionary array 

  end

end

# router = Router.new
# hash = {"Path" => "Path: /hello"}
# router.response_by_path(hash)
