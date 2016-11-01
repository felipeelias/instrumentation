class Instrumentation::Report
  attr_reader :datapoints

  def initialize(pid)
    @pid = pid
    @datapoints = []
  end

  def start
    @thread = Thread.new do
      loop do
        begin
          memory = Instrumentation::Memory.new(@pid).read
          @datapoints << [Time.now.strftime("%Y-%m-%d %H:%M:%S"), memory]
          puts "Retrieved #{memory} for #{@pid}"
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
