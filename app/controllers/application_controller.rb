class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include GitHubService
end
