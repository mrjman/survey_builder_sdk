require 'delegate'

module SurveyBuilder
  class Response < Delegator
    include Enumerable

    attr_accessor :request, :data, :meta

    def initialize(request, data)
      @request = request
      @data = data
      @meta = data.meta if data.respond_to?(:meta)
    end

    def each
      return to_enum unless block_given?

      response = self
      yield(response)

      until response.last_page?
        response = response.next_page
        yield(response)
      end
    end

    def pageable?
      !meta.nil?
    end

    def next_page?
      !!meta&.next_page
    end

    def prev_page?
      !!meat&.next_page
    end

    def last_page?
      !next_page?
    end

    def next_page
      return unless pageable?

      next_page_params = request.options.dup
      next_page_params[:page] = meta.next_page

      Request.new(request.client, request.service, request.method, next_page_params).call
    end

    def __getobj__
      @data
    end

    def __setobj__(obj)
      @data = obj
    end
  end
end
