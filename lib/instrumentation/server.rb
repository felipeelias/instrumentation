class Instrumentation::Server
  def initialize(report)
    @report = report
  end

  def proc
    @d3js  = File.read(asset_root.join('d3.min.js'))
    @c3js  = File.read(asset_root.join('c3.min.js'))
    @c3css = File.read(asset_root.join('c3.min.css'))

    context = binding

    Proc.new do |env|
      @datapoints = @report.datapoints
      ['200', {'Content-Type' => 'text/html'}, [template.result(context)]]
    end
  end

  def template
    ERB.new(File.read(template_root.join('index.html.erb')))
  end

  def template_root
    Instrumentation.root.join('lib/templates')
  end

  def asset_root
    Instrumentation.root.join('lib/assets')
  end
end
