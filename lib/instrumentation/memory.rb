module Instrumentation
  # Reads RSS memory from the PID specified
  class Memory
    def initialize(pid)
      @pid = pid
    end

    def read
      case system
      when :mac_os
        rss_via_ps
      else
        raise "Unknown system #{system.inspect}"
      end
    end

    def system
      :mac_os
    end

    def rss_via_ps
      `ps -o rss= -p #{@pid}`.strip.to_i
    end
  end
end
