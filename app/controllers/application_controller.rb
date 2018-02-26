class ApplicationController < ActionController::API
  def verify_authenticate
    return render json: {"status": "fail"} unless (User.find_by(access_token: params[:access_token]))
  end
end
