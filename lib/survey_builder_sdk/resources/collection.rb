module SurveyBuilder
  class Collection
    include Enumerable

    attr_accessor :operation, :limit, :options

    def initialize(operation, options = {})
      @operation = operation
      @options = options
    end

    def each(&block)
      return self unless block_given?

      batches.each do |batch|
        batch.each(&block)
      end
    end

    def batches(&block)
      operation.batches(options[:limit], &block)
    end

    def limit(limit)
      self.class.new(operation, options.merge(limit: limit))
    end
  end
end
