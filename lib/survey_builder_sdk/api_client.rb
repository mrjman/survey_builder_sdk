module SurveyBuilder
  class ApiClient
    def initialize(options = {})
      @api_access_id = options[:access_id] || ENV['SURVEY_BUILDER_API_ACCESS_ID']
      @api_secret = options[:secret] || ENV['SURVEY_BUILDER_API_SECRET']
      @api_url = options[:url] || ENV['SURVEY_BUILDER_API_URL']
      @cache_store = options[:cache_store]
    end

    def participants
      @participants ||= SurveyBuilder::ParticipantsService.new(participants_repository)
    end

    def surveys
      @surveys ||= SurveyBuilder::SurveysService.new(surveys_repository)
    end

    private

    def participants_repository
      SurveyBuilder::ParticipantsRepository.new(@api_access_id, @api_secret, @api_url, @cache_store)
    end

    def surveys_repository
      SurveyBuilder::SurveysRepository.new(@api_access_id, @api_secret, @api_url, @cache_store)
    end
  end
end
