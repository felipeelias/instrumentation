class Instrumentation::Report
  attr_reader :memory, :loadavg
  attr_accessor :socket

  def initialize(pid)
    @pid = pid
    @memory = Instrumentation::BoundedArray.new(300)
    @loadavg = Instrumentation::BoundedArray.new(300)
    @socket = nil
  end

  def start
    @thread = Thread.new do
      loop do
        begin
          memory = Instrumentation::Memory.new(@pid).read
          @memory = @memory << [Time.now.strftime("%FT%T"), memory]

          loadavg = Instrumentation::LoadAverage.new.read[:one]
          @loadavg = @loadavg << [Time.now.strftime("%FT%T"), loadavg]

          if socket
            socket.send_data({data_type: 'memory', data: @memory.items}.to_json)
            socket.send_data({data_type: 'loadavg', data: @loadavg.items}.to_json)
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

  def shutdown
    @thread.kill
  end
end
