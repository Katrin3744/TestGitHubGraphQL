module GitHubService
  class QueryError < StandardError; end

  def query(definition, variables = {})
    response = GitHubClient::CLIENT.query(definition, variables: variables, context: client_context)

    if response.errors.any?
      QueryError.new(response.errors[:data].join(", "))
    else
      response.data
    end
  end

  def client_context
    { access_token: GitHubClient::ACCESS_TOKEN }
  end
end
