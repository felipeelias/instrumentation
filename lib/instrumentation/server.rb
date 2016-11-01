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
        datapoints = @report.datapoints
        result     = @view.render(:index, datapoints: datapoints)
        ['200', {'Content-Type' => 'text/html'}, [result]]
      end
    end
  end
end
