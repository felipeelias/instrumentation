class Instrumentation::Server
  def initialize(report)
    @report = report
    @view   = Instrumentation::View.new
  end

  def proc
    Proc.new do |env|
      datapoints = @report.datapoints
      result     = @view.render(:index, datapoints: datapoints)
      ['200', {'Content-Type' => 'text/html'}, [result]]
    end
  end
end
