module Instrumentation
  # Webserver using `puma` that handles requests for stats
  class Webserver
    def initialize
      @worker = nil
    end

    def run(app, opts = {})
      config = build_config(opts.merge(app: app))

      @launcher = Puma::Launcher.new(config, events: Puma::Events.stdio)
      @worker = Thread.new { @launcher.run }
    end

    def join
      @worker.join
    end

    def stop
      @launcher.stop
      @worker.kill
    end

    private

    def build_config(opts)
      Puma::Configuration.new do |c|
        host = opts.fetch(:host, Puma::Configuration::DefaultTCPHost)
        port = opts.fetch(:port, Puma::Configuration::DefaultTCPPort)

        c.port port, host
        c.app  opts.fetch(:app)
      end
    end
  end
end
