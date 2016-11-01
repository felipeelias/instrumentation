class Instrumentation::View
  def render(template, data = {})
    @data = data
    erb(template).result(binding)
  end

  def asset(path)
    File.read(root.join('lib/assets', path))
  end

  def erb(template)
    ERB.new(File.read(root.join('lib/templates', "#{template}.html.erb")))
  end

  private

  def root
    Instrumentation.root
  end
end
