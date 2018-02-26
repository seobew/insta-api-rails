class UsersController < ApplicationController
  def own
		render json: {"own": "own"}
  end

  def own_media
		render json: {"own_media": "own_media"}
  end

  def individual
		puts params
		render json: {"individual": "individual"}
  end

  def individual_media
		render json: {"individual_media": "individual_media"}
  end
end
