require "./lib/server"

class StartServer

  def start_up
    s = Server.new
    s.start
  end
end

start = StartServer.new
start.start_up
