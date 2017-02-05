require 'tubesock'

module Instrumentation
  # Main Rack application that serves the `websocket` data or the index page
  class RackApp
    def initialize(report)
      @report = report
      @view   = Instrumentation::View.new
    end

    def call(env)
      if env['HTTP_UPGRADE'] == 'websocket'
        socket = Tubesock.hijack(env)
        socket.listen
        @report.socket = socket
        [-1, {}, []]
      else
        ['200', { 'Content-Type' => 'text/html' }, [@view.render]]
      end
    end
  end
end
