class ApplicationController < ActionController::API
before_action :authorize_request
private
    def authorize_request
    header = request.headers["Authorization"]
    token  = header.split(" ").last if header&.start_with?("Bearer ")
    decoded = JsonWebToken.decode(token)

    if decoded && decoded[:exp].to_i >= Time.now.to_i
      @current_user = User.find_by(id: decoded[:user_id])
      render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
    else
      render json: { error: "Invalid or expired token" }, status: :unauthorized
    end
  end

  def authorize_admin
    unless @current_user&.admin?
      render json: { error: "Forbidden - Admins only" }, status: :forbidden
    end
  end

end
