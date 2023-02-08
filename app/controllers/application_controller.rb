class ApplicationController < ActionController::Base
  include SessionsHelper

  # # 例外処理(本番環境でないと機能しない？)
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404

  # def render_404
  #   redirect_to root_path
  # end
end