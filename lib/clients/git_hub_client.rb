require "graphql/client"
require "graphql/client/http"

class GitHubClient
  ACCESS_TOKEN = Rails.application.secrets.github_access_token

  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      unless (token = context[:access_token] || ACCESS_TOKEN)
        fail "Missing GitHub access token"
      end

      {
        "Authorization" => "Bearer #{token}"
      }
    end
  end

  SCHEMA = GraphQL::Client.load_schema(HTTP)

  CLIENT = GraphQL::Client.new(schema: SCHEMA, execute: HTTP)
end
