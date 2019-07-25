module SurveyBuilder
  class Resource
    attr_accessor :client

    def initialize(options = {})
      @client = options.delete(:client) || ApiClient.new(options)
    end

    def surveys(options = {})
      options = options.merge(
        method: :list_surveys,
        resource_klass: Survey,
        service: :surveys
      )
      operation = Operation.new(client, options)
      Collection.new(operation)
    end

    def survey(uuid)
      Survey.new(client: client, uuid: uuid)
    end

    def participants(options = {})
      options = options.merge(
        method: :list_participants,
        resource_klass: Participant,
        service: :participants
      )
      operation = Operation.new(client, options)
      Collection.new(operation)
    end

    def participant(uuid)
      Participant.new(client: client, uuid: uuid)
    end
  end
end
