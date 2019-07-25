module SurveyBuilder
  class SurveysRepository < SurveyBuilder::EndpointRepository
    endpoint(
      :list,
      method: :get,
      path: '/surveys',
      data_element: :surveys
    )

    endpoint(
      :find,
      method: :get,
      path: '/surveys/:survey_uuid',
      data_element: :survey
    )

    endpoint(
      :list_answer_sets,
      method: :get,
      path: '/surveys/:survey_uuid/answer_sets'
    )

    endpoint(
      :find_answer_set,
      method: :get,
      path: '/surveys/:survey_uuid/answer_sets/:answer_set_uuid',
      data_element: :answer_set
    )
  end
end
