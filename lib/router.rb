require './lib/parse_request'
require 'pry'

class Router

  attr_accessor :guess

  def initialize
    @guess = guess
    @guess_counter = 0
  end

  def response_by_path(hash)

    @hello_counter ||= 0
    case
    when hash["Path"] == "Path: /"
      print_debugging(hash)
    when hash["Path"] == "Path: /hello"
      @hello_counter += 1
      print_hello
    when hash["Path"] == "Path: /datetime"
      print_date
    when hash["Path"].include?("Path: /word_search")
      print_word_search(hash)
    when hash["Path"] == "Path: /start_game"
      game_starts
    when hash["Path"] == "Path: /game" && hash["Verb"] == "Verb: POST"
      post_game
    when hash["Path"] == "Path: /game" && hash["Verb"] == "Verb: GET"
      get_game
    when hash["Path"] == "Path: /shutdown"
      print_shutdown
    else
      print_error
    end
  end

  def print_debugging(hash)
    parsed = ParseRequest.new
    parsed.format_hash(hash)
  end

  def print_hello
    "http/1.1 200 ok\r\n\r\n" + "Hello, World! #{@hello_counter}"
  end

  def print_date
    Time.now.strftime("%I:%M%p on %A, %B %d, %Y")
  end

  def print_shutdown
    "http/1.1 200 ok\r\n\r\n" + "Total Request:"
  end

  def pull_in_dictionary
    dict = File.readlines("/usr/share/dict/words")
    dict
  end

  def print_word_search(hash)
    word_path = hash["Path"]
    searched_word = word_path.split("=")[1]
    if pull_in_dictionary.include?("#{searched_word}\n")
      "#{searched_word} is a known word."
    else
      "#{searched_word} is not a known word."
    end
  end

  def get_game
    guess_count = "Guesses: #{@guess_counter += 1}"
    case
    when @guess < @random_guess
      guess_count + " " + "Your guess is too low"
    when @guess == @random_guess
      guess_count + " " + "You're correct!"
    when @guess > @random_guess
      guess_count + " " + "Your guess is too high"
    else
      "No guess was given"
    end
  end

  def post_game
    @guess
    status = "HTTP/1.1 303 See Other\n"
    location = "Location: http://127.0.0.1:9295/game\n\r"
    status + location
  end

  def game_starts
    @random_guess = rand(101)
    "Good luck!"
  end

  def print_error
    "http/1.1 200 ok\r\n\r\n" + "Not valid path"
  end

end
