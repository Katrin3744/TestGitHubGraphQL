class User::RepositoriesController < ApplicationController
  def index
    data = query(QueriesToGithub::UserRepoQuery, username: params[:login])
    respond_to do |format|
      if data.is_a?(QueryError) || data.user.nil?
        format.json { render :json => format_error(data) }
      else
        format.json { render :json => format_response(params[:login], parse_data(data)) }
      end
    end
  end

  private

  def format_error(data)
    {
      "response": {
        "error": data.inspect
      }
    }
  end

  def parse_data(data)
    data.user.repositories.nodes.map do |node|
      {
        "name": node.name,
        "created_at": node.created_at
      }
    end
  end

  def format_response(user_name, repositories)
    { "response": {
      "user": {
        "name": user_name
      },
      "repositories": repositories
    }
    }
  end
end
