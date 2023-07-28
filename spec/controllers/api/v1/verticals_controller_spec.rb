require 'rails_helper'

RSpec.describe Api::V1::VerticalsController, type: :controller do
  let(:token) { instance_double('Doorkeeper::AccessToken', acceptable?: true) }

  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end

  describe 'GET #index' do
    it 'returns a successful response with categories' do
      verticals = create_list(:vertical, 3)
      get :index
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data'].size).not_to be_nil
    end

    it 'returns an error response if something goes wrong' do
      allow_any_instance_of(::V1::VerticalService).to receive(:get_verticals).and_return(nil)
      get :index
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response with a vertical' do
      vertical = create(:vertical)
      get :show, params: { id: vertical.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['id']).to eq(vertical.id.to_s)
    end

    it 'returns an error response if vertical is not found' do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'POST #create' do
    it 'creates a new vertical and returns a successful response' do
      vertical_params = { name: 'Test Vertical' }
      post :create, params: { vertical: vertical_params }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['attributes']['name']).to eq('Test Vertical')
    end

    it 'returns an error response if creation fails' do
      allow_any_instance_of(::V1::VerticalService).to receive(:create_vertical).and_return([false, nil, ['Error message']])
      post :create, params: { vertical: {} }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'PATCH #update' do
    it 'updates the vertical and returns a successful response' do
      vertical = create(:vertical)
      update_params = { name: 'Updated Vertical' }
      patch :update, params: { id: vertical.id, vertical: update_params }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['attributes']['name']).to eq('Updated Vertical')
    end

    it 'returns an error response if update fails' do
      vertical = create(:vertical)
      allow_any_instance_of(::V1::VerticalService).to receive(:update_vertical).and_return([false, nil, ['Error message']])
      patch :update, params: { id: vertical.id, vertical: {} }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the vertical and returns a successful response' do
      vertical = create(:vertical)
      delete :destroy, params: { id: vertical.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['id']).to eq(vertical.id.to_s)
    end

    it 'returns an error response if deletion fails' do
      vertical = create(:vertical)
      allow_any_instance_of(::V1::VerticalService).to receive(:destroy_vertical).and_return(false)
      delete :destroy, params: { id: vertical.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
