# spec/controllers/api/v1/categories_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  let(:token) { instance_double('Doorkeeper::AccessToken', :acceptable? => true) }

  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end

  describe 'GET #index' do
    it 'returns a successful response with categories' do
      categories = create_list(:category, 3)
      get :index
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data'].size).not_to be_nil
    end

    it 'returns an error response if something goes wrong' do
      allow_any_instance_of(::V1::CategoryService).to receive(:get_categories).and_return(nil)
      get :index
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response with a category' do
      category = create(:category)
      get :show, params: { id: category.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['id']).to eq(category.id.to_s)
    end

    it 'returns an error response if category is not found' do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'POST #create' do
    it 'creates a new category and returns a successful response' do
      vertical = create(:vertical)
      category_params = { name: 'Test Category', state: 'active', vertical_id: vertical.id }
      post :create, params: { category: category_params }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['attributes']['name']).to eq('Test Category')
    end

    it 'returns an error response if creation fails' do
      allow_any_instance_of(::V1::CategoryService).to receive(:create_category).and_return([false, nil, ['Error message']])
      post :create, params: { category: {} }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'PATCH #update' do
    it 'updates the category and returns a successful response' do
      category = create(:category)
      update_params = { name: 'Updated Category' }
      patch :update, params: { id: category.id, category: update_params }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['attributes']['name']).to eq('Updated Category')
    end

    it 'returns an error response if update fails' do
      category = create(:category)
      allow_any_instance_of(::V1::CategoryService).to receive(:update_category).and_return([false, nil, ['Error message']])
      patch :update, params: { id: category.id, category: {} }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the category and returns a successful response' do
      category = create(:category)
      delete :destroy, params: { id: category.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['id']).to eq(category.id.to_s)
    end

    it 'returns an error response if deletion fails' do
      category = create(:category)
      allow_any_instance_of(::V1::CategoryService).to receive(:destroy_category).and_return(false)
      delete :destroy, params: { id: category.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
