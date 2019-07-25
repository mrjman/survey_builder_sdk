module SurveyBuilder
  class ParticipantsRepository < SurveyBuilder::EndpointRepository
    # participant

    endpoint(
      :list,
      method: :get,
      path: '/participants',
      data_element: :participants
    )

    endpoint(
      :create,
      method: :post,
      path: '/participants',
      data_element: :participant
    )

    endpoint(
      :find,
      method: :get,
      path: '/participants/:participant_uuid',
      data_element: :participant
    )

    endpoint(
      :update,
      method: :put,
      path: '/participants/:participant_uuid',
      data_element: :participant
    )

    # answer_sets

    endpoint(
      :list_answer_sets,
      method: :get,
      path: '/participants/:participant_uuid/answer_sets',
      data_element: :answer_sets
    )

    endpoint(
      :create_answer_set,
      method: :post,
      path: '/participants/:participant_uuid/answer_sets',
      data_element: :answer_set
    )

    endpoint(
      :clone_answer_set,
      method: :post,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/clone',
      data_element: :answer_set
    )

    endpoint(
      :update_question_group_answers,
      method: :put,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/question_groups/:question_group_uuid',
      data_element: :answers
    )

    endpoint(
      :find_answer_set,
      method: :get,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid',
      data_element: :answer_set
    )

    endpoint(
      :find_answer_set_verbose,
      method: :get,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/verbose',
      data_element: :answer_set
    )

    endpoint(
      :update_answer_set,
      method: :put,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid',
      data_element: :answer_set
    )

    # answer groups

    endpoint(
      :list_answer_groups,
      method: :get,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/answer_groups',
      data_element: :answer_groups
    )

    endpoint(
      :find_answer_group,
      method: :get,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/answer_groups/:answer_group_uuid',
      data_element: :answer_group
    )

    endpoint(
      :create_answer_group,
      method: :post,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/answer_groups',
      data_element: :answer_group
    )

    endpoint(
      :update_answer_group,
      method: :put,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/answer_groups/:answer_group_uuid',
      data_element: :answer_group
    )

    endpoint(
      :delete_answer_group,
      method: :delete,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/answer_groups/:answer_group_uuid',
      data_element: :answer_group
    )

    # answers

    endpoint(
      :list_answers,
      method: :get,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/answers',
      data_element: :answers
    )

    endpoint(
      :create_answer,
      method: :post,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/answers',
      data_element: :answer
    )

    endpoint(
      :find_answer,
      method: :get,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/answers/:answer_uuid',
      data_element: :answer
    )

    endpoint(
      :update_answer,
      method: :put,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/answers/:answer_uuid',
      data_element: :answer
    )

    endpoint(
      :delete_answer,
      method: :delete,
      path: '/participants/:participant_uuid/answer_sets/:answer_set_uuid/answers/:answer_uuid',
      data_element: :answer
    )

    # surveys

    endpoint(
      :get_surveys,
      method: :get,
      path: '/participants/:participant_uuid/surveys',
      data_element: :surveys
    )
  end
end
