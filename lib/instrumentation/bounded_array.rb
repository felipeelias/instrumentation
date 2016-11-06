module Instrumentation
  # Array with bounded size. If the max size is exceeded it pops the first
  # element and adds the new element at the end of the array
  class BoundedArray
    attr_reader :max_size
    attr_reader :items

    def initialize(max_size, items = [])
      @max_size = max_size
      @items = items
    end

    def <<(item)
      slice = @items
      slice = @items[1..-1] if max_reached?

      BoundedArray.new(max_size, slice + [item])
    end

    private

    def max_reached?
      items.size >= @max_size
    end
  end
end
