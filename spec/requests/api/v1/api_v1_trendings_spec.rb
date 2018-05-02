require 'rails_helper'

RSpec.describe "Api::V1::Trendings", type: :request do

  describe 'GET /api/v1/trending/index' do
    context 'Authenticated' do

      before { create_list(:trending, 5) }
      let(:user) { create(:user) }

      it 'return success' do
        get "/api/v1/trending/index", headers: header_with_authentication(user)
        expect(response).to have_http_status(:success)
      end

      it 'return the right hashtags' do
        last_trending = create(:trending, hashtags: {'#ruby': 2, '#tdd': 5, '#react': 8})
        get "/api/v1/trending/index", headers: header_with_authentication(user)
        expect(json["hashtags"]).to eq(last_trending.hashtags)
      end
    end
  end
end
