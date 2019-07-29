module SurveyBuilder
  class Participant
    attr_reader :client, :uuid

    def initialize(options = {})
      @client = options[:client] || ApiClient.new(options)
      @uuid = options[:uuid]
    end

    def data
      return @data if loaded?

      load
      @data
    end

    def loaded?
      !@data.nil?
    end

    def load
      response = client.participants.find_participant(uuid)

      if response.errors.nil?
        @data = response
      else
        @data = nil
        raise "unable to load participant #{uuid}"
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

    # Associations
    def answer_sets(options = {})
      options = options.merge(
        args: [uuid],
        method: :list_answer_sets,
        resource_klass: AnswerSetSummary,
        service: :participants
      )

      operation = SurveyBuilder::Operation.new(client, options)
      SurveyBuilder::Collection.new(operation)
    end

    private

    def retrieve_data(key)
      data[key.to_s]
    end
  end
end
