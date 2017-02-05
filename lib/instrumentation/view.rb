module Instrumentation
  # Handles rendering of ERB templates and asset loading
  class View
    include Erb::View
    template :index

    def asset(path)
      File.read(asset_root.join('lib/assets', path))
    end

    private

    def asset_root
      Instrumentation.root
    end
  end
end
