module SurveyBuilder
  class SurveysService
    attr_reader :client

    def initialize(surveys_repository)
      @client = surveys_repository
    end

    # surveys

    def list_surveys
      client.list
    end

    def find_survey(survey_uuid)
      return if survey_uuid.nil?

      client.find(survey_uuid: survey_uuid)
    end

    # answer sets

    def list_answer_sets(survey_uuid, options = {})
      return if survey_uuid.nil?

      client.list_answer_sets(
        options.merge(survey_uuid: survey_uuid)
      )
    end

    def find_answer_set(survey_uuid, answer_set_uuid)
      return if survey_uuid.nil? || answer_set_uuid.nil?

      client.find_answer_set(
        survey_uuid: survey_uuid,
        answer_set_uuid: answer_set_uuid
      )
    end
  end
end
