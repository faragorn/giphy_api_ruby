module GiphyAPI
  class Collection
    include Enumerable

    PAGINATION_ATTRIBUTES = [:total_count, :offset].freeze

    attr_accessor :elements, *PAGINATION_ATTRIBUTES

    def initialize(elements)
      @elements = elements
    end

    def each &block
      elements.each(&block)
    end

    def count
      elements.length
    end

    def collect!
      return elements unless block_given?
      set = []
      each { |e| set << yield(e) }
      @elements = set
      self
    end
  end
end