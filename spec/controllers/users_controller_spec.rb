require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #own" do
    it "returns http success" do
      get :own
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #own_media" do
    it "returns http success" do
      get :own_media
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #individual" do
    it "returns http success" do
      get :individual
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #individual_media" do
    it "returns http success" do
      get :individual_media
      expect(response).to have_http_status(:success)
    end
  end

end
