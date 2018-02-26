class UsersController < ApplicationController
  before_action :verify_authenticate
	before_action :set_current_user, only: [:own, :own_media]
	before_action :set_individual_user, only: [:individual, :individual_media]
  def own
		render json: @user, except: [:access_token]
  end

  def own_media
		#render json: {"own_media": "own_media"}
  end

  def individual
		render json: @user, except: [:access_token]
  end

  def individual_media
		#render json: {"individual_media": "individual_media"}
  end

  private
		def set_current_user
			@user = User.find_by(access_token: params[:access_token])
		end

		def set_individual_user
			@user = User.find_by(id: params[:user_id])
			if @user.nil?
				render json: {"status": "fail"}
			end
		end
end
