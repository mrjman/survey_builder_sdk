module SurveyBuilder
  class ParticipantsService
    attr_reader :client

    def initialize(participants_repository)
      @client = participants_repository
    end

    # participants

    def list_participants
      client.list
    end

    def create_participant
      client.create
    end

    def find_participant(participant_uuid)
      client.find(
        participant_uuid: participant_uuid
      )
    end

    def update_participant(participant_uuid)
      client.update_participant(
        participant_uuid: participant_uuid
      )
    end

    # answer sets

    def list_answer_sets(participant_uuid)
      client.list_answer_sets(
        participant_uuid: participant_uuid
      )
    end

    def create_answer_set(participant_uuid, survey_uuid)
      client.create_answer_set(
        participant_uuid: participant_uuid,
        answer_set: {
          survey_uuid: survey_uuid
        }
      )
    end

    def clone_answer_set(participant_uuid, answer_set_uuid)
      client.clone_answer_set(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid
      )
    end

    def find_answer_set(participant_uuid, answer_set_uuid, verbose = false)
      params = {
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid
      }

      if verbose
        client.find_answer_set_verbose(params)
      else
        client.find_answer_set(params)
      end
    end

    def update_answer_set(participant_uuid, answer_set_uuid)
      client.update_answer_set(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid
      )
    end

    # answer groups

    def list_answer_groups(participant_uuid, answer_set_uuid)
      client.list_answer_groups(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid
      )
    end

    def find_answer_group(participant_uuid, answer_set_uuid, answer_group_uuid)
      client.find_answer_group(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid,
        answer_group_uuid: answer_group_uuid
      )
    end

    def create_answer_group(participant_uuid, answer_set_uuid, question_group_uuid, answers)
      client.create_answer_group(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid,
        answer_group: {
          question_group_uuid: question_group_uuid,
          answers: answers
        }
      )
    end

    def update_answer_group(participant_uuid, answer_set_uuid, answer_group_uuid, answers)
      client.update_answer_group(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid,
        answer_group_uuid: answer_group_uuid,
        answer_group: {
          answers: answers
        }
      )
    end

    def delete_answer_group(participant_uuid, answer_set_uuid, answer_group_uuid)
      client.delete_answer_groups(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid,
        answer_group_uuid: answer_group_uuid
      )
    end

    # answers

    def list_answers(participant_uuid, answer_set_uuid)
      client.list_answers(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid
      )
    end

    def create_answer(participant_uuid, answer_set_uuid, question_uuid, values)
      client.create_answer(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid,
        answer: {
          question_uuid: question_uuid,
          values: ensure_values(values)
        }
      )
    end

    def find_answer(participant_uuid, answer_set_uuid, answer_uuid)
      client.find_answer(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid,
        answer_uuid: answer_uuid
      )
    end

    def update_answer(participant_uuid, answer_set_uuid, answer_uuid, question_uuid, values)
      client.update_answer(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid,
        answer_uuid: answer_uuid,
        answer: {
          question_uuid: question_uuid,
          values: ensure_values(values)
        }
      )
    end

    def delete_answer(participant_uuid, answer_set_uuid, answer_uuid)
      client.delete_answer(
        participant_uuid: participant_uuid,
        answer_set_uuid: answer_set_uuid,
        answer_uuid: answer_uuid
      )
    end

    # surveys

    def list_surveys(participant_uuid)
      client.get_surveys(
        participant_uuid: participant_uuid
      )
    end

    private

    # ensures values are in array format and removes empties
    def ensure_values(values)
      Util.array_wrap(values).reject do |v|
        v.nil? || (v.respond_to?(:empty?) && v.empty?)
      end
    end
  end
end
