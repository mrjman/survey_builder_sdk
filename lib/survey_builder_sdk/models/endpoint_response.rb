require 'json'

module SurveyBuilder
  class EndpointResponse
    attr_reader :success, :value

    def initialize(faraday_response)
      @success = faraday_response.success?
      @value = safe_parse_json(faraday_response.body)
    end

    def success?
      success
    end

    private

    def safe_parse_json(text)
      JSON.parse(text, object_class: OpenStruct)
    rescue JSON::ParserError
      nil
    end
  end
end
