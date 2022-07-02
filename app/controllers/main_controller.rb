class MainController < ActionController::Base
  def index
    render plain: 'hi'
  end
end
