# frozen_string_literal: true

module GraphqlHelper
  def execute_query(query, variables = {})
    converted_variables = variables.deep_transform_keys { |key| key.to_s.camelize(:lower) } || {}

    SkillbridgeSchema.execute(query:, variables: converted_variables, context: { current_user: user })
  end

  def graphql_id(object)
    SkillbridgeSchema.id_from_object(object, nil, {})
  end

  def from_graphql_id(id)
    return nil unless id

    SkillbridgeSchema.object_from_id(id, {})
  end
end
