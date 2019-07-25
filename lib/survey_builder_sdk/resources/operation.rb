module SurveyBuilder
  class Operation
    attr_accessor :client, :resource_key, :resource_klass, :method, :service, :options

    def initialize(client, options = {})
      @client = client
      @service = options.delete(:service)
      @method = options.delete(:method)
      @resource_key = options.delete(:resource_key)
      @resource_klass = options.delete(:resource_klass)
      @options = options
    end

    def batches(limit, &block)
      enum_for(:execute, limit, &block)
    end

    def request
      Request.new(client, service, method, options)
    end

    private

    def execute(limit)
      response = request.call

      remaining = limit

      response.each do |resp|
        resources = parsed_resources(resp)

        if remaining && remaining < resources.size
          yield(Batch.new(resources.first(remaining)))
          break
        else
          remaining -= resources.size unless remaining.nil?
          yield(Batch.new(resources))
        end
      end
    end

    def parsed_resources(response)
      data = resource_key.nil? ? response.data : response.send(resource_key)

      if resource_klass
        data.map do |item|
          resource_klass.new(options.merge(uuid: item[:uuid], data: item))
        end
      else
        data
      end
    end
  end
end
