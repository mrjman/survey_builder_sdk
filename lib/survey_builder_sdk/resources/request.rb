module SurveyBuilder
  class Request
    attr_accessor :client, :method, :service, :service_klass, :args, :params, :options

    def initialize(client, service, method, options = {})
      @client = client
      @service = service
      @service_klass = client.send(service)
      @method = method
      @options = options
      @args = Util.array_wrap(options[:args])
      @params = options.dup.tap { |hash| hash.delete(:args) }
    end

    def call
      data = service_klass.send(method, *request_args)

      Response.new(self, data)
    end

    private

    def request_args
      args + Util.array_wrap(params.empty? ? nil : params)
    end
  end
end
