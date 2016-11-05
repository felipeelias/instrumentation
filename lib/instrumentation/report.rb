class Instrumentation::Report
  attr_reader :datapoints
  attr_accessor :socket

  def initialize(pid)
    @pid = pid
    @datapoints = Instrumentation::BoundedArray.new(300)
    @socket = nil
  end

  def start
    @thread = Thread.new do
      loop do
        begin
          memory = Instrumentation::Memory.new(@pid).read
          @datapoints = @datapoints << [Time.now.strftime("%FT%T"), memory]
          puts "Retrieved #{memory} for #{@pid}"
          if socket
            socket.send_data @datapoints.items.to_json
          end
          sleep 1
        rescue => e
          puts e
        end
      end
    end
  end

  def join
    @thread.join
  end
end
