module SurveyBuilder
  class AnswerSetSummary
    attr_reader :client, :uuid, :data

    def initialize(options = {})
      @uuid = options[:uuid]
      @survey_uuid = options[:survey_uuid]
      @participant_uuid = options[:participant_uuid]
      @data = options[:data]
      @client = options[:client] || ApiClient.new(options)
    end

    # Attributes
    def survey_uuid
      retrieve_data(:survey_uuid)
    end

    def participant_uuid
      retrieve_data(:participant_uuid)
    end

    def created_at
      retrieve_data(:created_at)
    end

    def updated_at
      retrieve_data(:updated_at)
    end

    # Associations
    def answer_set
      @answer_set ||= AnswerSet.new(
        client: client,
        uuid: uuid,
        survey_uuid: survey_uuid,
        participant_uuid: participant_uuid
      )
    end

    def survey
      @survey ||= Survey.new(client: client, uuid: survey_uuid)
    end

    def participant
      @participant ||= Participant.new(client: client, uuid: participant_uuid)
    end

    private

    def retrieve_data(key)
      data[key.to_s]
    end
  end
end
