module SurveyBuilder
  class Request
    attr_accessor :client, :method, :service, :args, :params, :options

    def initialize(client, service, method, options = {})
      @client = client
      @service = client.send(service)
      @method = method
      @options = options
      @args = SurveyBuilder::Util.array_wrap(options[:args])
      @params = options.dup.tap { |hash| hash.delete(:args) }
    end

    def call
      data = service.send(method, *request_args)

      SurveyBuilder::Response.new(self, data)
    end

    private

    def request_args
      args + Util.array_wrap(params.empty? ? nil : params)
    end
  end
end
