class MediaController < ApplicationController
  def show
		@media = Medium.find(params[:media_id])
    render json: @media
  end
end
