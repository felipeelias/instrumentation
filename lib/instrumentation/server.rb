require 'tubesock'

class Instrumentation::Server
  def initialize(report)
    @report = report
    @view   = Instrumentation::View.new
  end

  def proc
    Proc.new do |env|
      if env["HTTP_UPGRADE"] == 'websocket'
        tubesock = Tubesock.hijack(env)
        tubesock.onmessage do |message|
          puts "Got #{message}"
        end
        tubesock.listen
        @report.socket = tubesock
        [ -1, {}, [] ]
      else
        ['200', {'Content-Type' => 'text/html'}, [@view.render(:index)]]
      end
    end
  end
end
