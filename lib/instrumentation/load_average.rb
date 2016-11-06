module Instrumentation
  # Reads loadavg metric from system
  class LoadAverage
    class << self
      # Input string looks like:
      #   "{ 1.62 1.59 2.03 }"
      # @returns
      #   {:one=>"1.62", :five=>"1.59", :ten=>"2.03"}
      def parse_osx(input)
        %i(one five ten).zip(input.scan(/([0-9\.]+)/).flatten).to_h
      end
    end

    def read
      case system
      when :mac_os
        self.class.parse_osx(last_value)
      else
        raise "Unknown system #{system.inspect}"
      end
    end

    private

    def system
      :mac_os
    end

    def last_value
      `sysctl -n vm.loadavg`
    end
  end
end
