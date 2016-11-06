require 'instrumentation/version'
require 'pathname'
require 'erb'
require 'json'
require 'rack'
require 'puma'

module Instrumentation
  extend self

  def start_server(pid:, port: 8080)
    report = Report.new(pid)
    app = RackApp.new(report)
    server = Webserver.new

    report.start
    server.run(app, port: port)

    server.join
    report.join
  rescue Interrupt => _
    print "\n=> Shutting down instrumentation.\n"
    report.shutdown
    server.stop
  end

  def root
    Pathname.new(__FILE__).join('..', '..')
  end
end

require 'instrumentation/bounded_array'
require 'instrumentation/memory'
require 'instrumentation/load_average'
require 'instrumentation/rack_app'
require 'instrumentation/report'
require 'instrumentation/view'
require 'instrumentation/webserver'
