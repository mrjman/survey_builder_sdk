module SurveyBuilder
  class Batch
    include Enumerable

    attr_accessor :resources

    def initialize(resources)
      @resources = resources || []
    end

    def each(&block)
      enum = resources.to_enum
      enum.each(&block) if block_given?
      enum
    end
  end
end
