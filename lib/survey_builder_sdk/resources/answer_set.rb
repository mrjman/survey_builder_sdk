module SurveyBuilder
  class AnswerSet
    attr_reader :client, :uuid

    def initialize(options = {})
      @uuid = options[:uuid]
      @survey_uuid = options[:survey_uuid]
      @participant_uuid = options[:participant_uuid]
      @data = options[:data]
      @client = options[:client] || ApiClient.new(options)
    end

    def loaded?
      !@data.nil?
    end

    def data
      return @data if loaded?

      load
      @data
    end

    def load
      service = @survey_uuid ? client.surveys : client.participants
      parent_uuid = @survey_uuid || @participant_uuid
      response = service.find_answer_set(parent_uuid, @uuid)

      if response.errors.nil?
        @data = response
      else
        @data = nil
        raise "unable to load answer set #{uuid}"
      end

      self
    end
    alias reload load

    # Attributes
    def created_at
      time_str = retrieve_data(:created_at)
      Util.str_to_time(time_str)
    end

    def updated_at
      time_str = retrieve_data(:updated_at)
      Util.str_to_time(time_str)
    end

    def cloned_from_uuid
      retrieve_data(:cloned_from_uuid)
    end

    # Associations
    def survey
      survey_uuid = @survey_uuid || retrieve_data(:survey_uuid)
      @survey ||= Survey.new(client: client, survey: survey_uuid)
    end

    def participant
      participant_uuid = @participant_uuid || retrieve_data(:participant_uuid)
      @participant ||= Participant.new(client: client, participant: participant_uuid)
    end

    def cloned_from
      return if cloned_from_uuid.nil?

      @cloned_from ||= AnswerSet.new(client: client, uuid: cloned_from_uuid, survey_uuid: @survey_uuid, participant_uuid: @participant_uuid)
    end

    private

    def retrieve_data(key)
      data[key.to_s]
    end
  end
end
