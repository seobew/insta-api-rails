class UsersController < ApplicationController
  before_action :verify_authenticate
	before_action :set_current_user, only: [:own, :own_media, :self_follow, :self_followed_by, :self_requested_by]
	before_action :set_individual_user, only: [:individual, :individual_media]
  def own
		render json: @user, except: [:access_token]
  end

  def own_media
		render json: @user.media.last
  end

  def individual
		render json: @user, except: [:access_token]
  end

  def individual_media
		render json: @user.media.last
  end

  def self_follow
    followees = @user.follower_relationship
    @followees = followees.select{|r| r.accepted}
    render json: @followees
  end

  def self_followed_by
    followers = @user.followee_relationship
    @accepted_followers = followers.select{|r| r.accepted}
    render json: @accepted_followers
  end

  def self_requested_by
    followers = @user.followee_relationship
    @waiting_followers = followers.select{|r| r.accepted==false}
    render json: @waiting_followers
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
