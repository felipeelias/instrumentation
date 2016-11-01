require 'instrumentation/version'
require 'rack'
require 'pathname'

module Instrumentation
  extend self

  def start_server(pid:)
    report = Report.new(pid)
    server = Server.new(report)
    report.start
    Rack::Handler::WEBrick.run(server.proc)
    report.join
  end

  def root
    Pathname.new(__FILE__).join('..', '..')
  end
end

require 'instrumentation/memory'
require 'instrumentation/server'
require 'instrumentation/report'
