class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :users

  before_filter :authenticate

  def authenticate
    if authenticate_with_http_basic {|username, password|
      if users[username] == password
        @current_user = username
      end
    }
    else
      request_http_basic_authentication
    end
  end

  def current_user
    @current_user
  end

  def users
    JSON.parse(ENV['USERS'])
  end
end
