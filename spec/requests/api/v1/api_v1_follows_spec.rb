require 'rails_helper'

RSpec.describe "Api::V1::Follows", type: :request do
  describe 'POST /api/v1/users/:id/follow' do

    context 'Authenticated' do
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }

      it 'return created' do
        post "/api/v1/users/#{another_user.id}/follow", headers: header_with_authentication(user)
        expect(response).to have_http_status(:created)
      end

      it 'user was followed by current_user' do
        post "/api/v1/users/#{another_user.id}/follow", headers: header_with_authentication(user)
        expect(user.following? another_user).to be_truthy
      end

      it 'current_user follows count increase by one' do
        expect do
          post "/api/v1/users/#{another_user.id}/follow", headers: header_with_authentication(user)
        end.to change { user.follow_count }.by(1)
      end
    end
  end

  describe 'DELETE /api/v1/users/:id/follow' do

    context 'Authenticated' do

      let(:user) { create(:user) }
      let(:another_user) { create(:user) }
      before { user.follow(another_user) }

      it do
        delete "/api/v1/users/#{another_user.id}/follow", headers: header_with_authentication(user)
        expect(response).to have_http_status(:no_content)
      end

      it 'user stopped being following by current_user' do
        delete "/api/v1/users/#{another_user.id}/follow", headers: header_with_authentication(user)
        expect(user.following? another_user).to be_falsy
      end

      it 'current_user decrease the number of follows' do
        expect do
          delete "/api/v1/users/#{another_user.id}/follow", headers: header_with_authentication(user)
        end.to change { user.follow_count }.from(1).to(0)
      end
    end
  end
end
