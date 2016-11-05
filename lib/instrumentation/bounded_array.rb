module Instrumentation
  class BoundedArray
    attr_reader :max_size
    attr_reader :items

    def initialize(max_size, items = [])
      @max_size = max_size
      @items = items
    end

    def <<(item)
      slice = if items.size >= @max_size
        @items[1..-1]
      else
        @items
      end
      BoundedArray.new(max_size, slice + [item])
    end
  end
end
