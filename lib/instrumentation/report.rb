module Instrumentation
  # Reads data from system and process information and writes it to
  # websocket
  class Report
    attr_reader :memory, :loadavg
    attr_accessor :socket

    def initialize(pid)
      @pid = pid
      @sleep = 1
      @memory = BoundedArray.new(300)
      @loadavg = BoundedArray.new(300)
      @socket = nil
    end

    def start
      @thread = Thread.new do
        loop do
          read_data
          send_data if socket
          sleep @sleep
        end
      end
    end

    def read_data
      now = Time.now.strftime('%FT%T')
      @memory = @memory << [now, read_memory]
      @loadavg = @loadavg << [now, read_loadavg]
    rescue => error
      puts "Error when reading data: #{error.inspect}"
    end

    def send_data
      socket.send_data(event(:memory, @memory.items))
      socket.send_data(event(:loadavg, @loadavg.items))
    rescue => error
      puts "Error when sending data: #{error.inspect}"
    end

    def event(name, data)
      { data_type: name, data: data }.to_json
    end

    def read_memory
      Memory.new(@pid).read
    end

    def read_loadavg
      LoadAverage.new.read[:one]
    end

    def join
      @thread.join
    end

    def shutdown
      @thread.kill
    end
  end
end
