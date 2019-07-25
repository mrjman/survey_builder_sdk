require 'time'

module SurveyBuilder
  class Survey
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
      response = client.surveys.find_survey(uuid)

      if response.errors.nil?
        @data = response
      else
        @data = nil
        raise "unable to load survey #{uuid}"
      end

      self
    end
    alias reload load

    # Attributes
    def title
      retrieve_data(:title)
    end

    def description
      retrieve_data(:description)
    end

    def created_at
      time_str = retrieve_data(:created_at)
      Time.parse(time_str) if time_str
    end

    def updated_at
      time_str = retrieve_data(:updated_at)
      Time.parse(time_str) if time_str
    end

    def question_groups
      retrieve_data(:question_groups)
    end

    # Associations
    def answer_sets(options = {})
      options = options.merge(
        args: [uuid],
        method: :list_answer_sets,
        resource_key: :answer_sets,
        resource_klass: AnswerSetSummary,
        service: :surveys
      )

      operation = SurveyBuilder::Operation.new(client, options)
      SurveyBuilder::Collection.new(operation)
    end

    def answer_set(answer_set_uuid)
      AnswerSet.new(client: client, survey_uuid: uuid, uuid: answer_set_uuid)
    end

    private

    def retrieve_data(key)
      data[key.to_s]
    end
  end
end
