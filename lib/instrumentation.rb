require 'instrumentation/version'
require 'pathname'
require 'erb'
require 'json'
require 'rack'
require 'puma'
require 'rack/handler/puma'

module Instrumentation
  extend self

  def start_server(pid:)
    report = Report.new(pid)
    server = Server.new(report)
    report.start
    Rack::Handler::Puma.run(server.proc, Port: 8080)
    report.join
  end

  def root
    Pathname.new(__FILE__).join('..', '..')
  end
end

require 'instrumentation/bounded_array'
require 'instrumentation/memory'
require 'instrumentation/server'
require 'instrumentation/report'
require 'instrumentation/view'
