require 'json'
require 'faraday'

module SurveyBuilder
  class EndpointRepository
    def initialize(api_access_id, api_secret, api_url, cache_store)
      @api_access_id = api_access_id
      @api_secret = api_secret
      @api_url = api_url
      @cache_store = cache_store
    end

    def self.endpoint(action, config)
      define_method(action) do |params = nil|
        send(:process_request, config[:method], config[:path], params, config[:data_element])
      end
    end

    def self.method_allows_body?(method)
      Faraday::Env::MethodsWithBodies.include?(method.downcase.to_sym)
    end

    private

    def process_request(method, path, params, data_element = nil)
      request_url = build_url(path.dup, params, strip_params: true)

      if method_allows_body?(method)
        request_body = params.to_json
      else
        query_params = (params || {}).compact
        request_url += "?#{Util.to_query(query_params)}" unless query_params.empty?
      end

      request_method = method.to_sym

      auth_token = build_authorization_token(request_url, request_body, request_method)
      connection.token_auth(auth_token)

      response = connection.send(request_method) do |request|
        request.url request_url
        request.body = request_body
      end

      process_response(
        response,
        data_element
      )
    end

    def process_response(response, data_element = nil)
      return nil if response.status == 404

      value = safe_parse_json(response.body)

      if data_element
        if value.respond_to?(data_element)
          value = value.send(data_element)
        elsif !value.respond_to?(:errors)
          raise 'invalid response'
        end
      end

      value
    end

    def safe_parse_json(text)
      JSON.parse(text, object_class: SurveyBuilder::ApiOpenStruct)
    rescue JSON::ParserError
      JSON.parse(
        '{ "errors": { "response": "invalid response" } }',
        object_class: SurveyBuilder::ApiOpenStruct
      )
    end

    def build_authorization_token(request_url, request_body, request_method)
      signature = build_signature(request_url, request_body, request_method)
      "#{@api_access_id}:#{signature}"
    end

    def build_signature(request_url, request_body, request_method)
      uri = URI(request_url.to_s)
      url = "#{uri.request_uri}#{uri.fragment}"
      body = request_body
      method = request_method.to_s.upcase

      data = "#{url}#{body}#{method}"
      digest = OpenSSL::Digest.new('sha1')
      OpenSSL::HMAC.hexdigest(digest, @api_secret, data)
    end

    def build_url(action, params, strip_params = false)
      action.tap do |a|
        (params || {}).dup.each do |k, v|
          if /:#{k}/ =~ a
            a.gsub!(/:#{k}/, v)
            params.delete(k) if strip_params
          end
        end
      end

      "#{connection.url_prefix}#{action}.json"
    end

    def connection_options
      {
        url: @api_url,
        headers: {
          content_type: 'application/json',
          accepts: 'application/json'
        }
      }
    end

    def connection
      @connection ||= Faraday.new(connection_options) do |conn|
        unless @cache_store.nil?
          conn.use(
            :http_cache,
            store: @cache_store,
            logger: Rails.logger,
            serializer: Marshal,
            shared_cache: false
          )
        end

        conn.use SurveyBuilder::RaiseError
        conn.adapter :net_http
      end
    end

    def method_allows_body?(method)
      self.class.method_allows_body?(method)
    end
  end
end
