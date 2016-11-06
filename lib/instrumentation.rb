require 'instrumentation/version'
require 'pathname'
require 'erb'
require 'json'
require 'rack'
require 'puma'

# Instrumentation
#
# Start a server by calling:
#   Instrumentation.start_server(Process.pid)
#
# By default the server is started on http://localhost:8080
module Instrumentation
  def start_server(pid:, port: 8080)
    report = Report.new(pid)
    app = RackApp.new(report)
    server = Webserver.new

    report.start
    server.run(app, port: port)

    [server, report].map(&:join)
  rescue Interrupt => _
    print "\n=> Shutting down instrumentation.\n"
    report.shutdown
    server.stop
  end

  def root
    Pathname.new(__FILE__).join('..', '..')
  end

  module_function :start_server, :root
end

require 'instrumentation/bounded_array'
require 'instrumentation/memory'
require 'instrumentation/load_average'
require 'instrumentation/rack_app'
require 'instrumentation/report'
require 'instrumentation/view'
require 'instrumentation/webserver'
