class User::CommitsController < ApplicationController
  def index
    data = query(QueriesToGithub::UserRepoCommitQuery, username: params[:login], repository: params[:repo])
    respond_to do |format|
      if data.is_a?(QueryError) || data.repository.nil?
        format.json { render :json => format_error(data) }
      else
        format.json { render :json => format_response(params[:repo], parse_data(data)) }
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
    data.repository.ref.target.history.edges.map do |edge|
      {
        "message": edge.node.message,
        "commit_date": edge.node.committed_date
      }
    end
  end

  def format_response(repo_name, commits)
    {
      "response": {
        "repo": {
          "name": repo_name,
          "commits": commits
        }
      }
    }
  end
end
