require 'rails_helper'

RSpec.describe "Api::V1::Likes", type: :request do
  describe 'POST /api/v1/tweets/:id/like' do

    context 'Authenticated' do
      let(:user) { create(:user) }
      let(:tweet) { create(:tweet) }

      it 'return created' do
        post "/api/v1/tweets/#{tweet.id}/like", headers: header_with_authentication(user)
        expect(response).to have_http_status(:created)
      end

      it 'tweet was liked by user' do
        post "/api/v1/tweets/#{tweet.id}/like", headers: header_with_authentication(user)
        expect(tweet.liked_by user).to be_truthy
      end
    end
  end

  describe 'DELETE /api/v1/tweets/:id/like' do

    context 'Authenticated' do

      let(:user) { create(:user) }
      let(:tweet) { create(:tweet) }

      it do
        delete "/api/v1/tweets/#{tweet.id}/like", headers: header_with_authentication(user)
        expect(response).to have_http_status(:no_content)
      end

      it 'tweet was unliked by user' do
        delete "/api/v1/tweets/#{tweet.id}/like", headers: header_with_authentication(user)
        expect(tweet.unliked_by user).to be_truthy
      end
    end
  end
end
