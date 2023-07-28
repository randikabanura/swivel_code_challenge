require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  let(:token) { instance_double('Doorkeeper::AccessToken', acceptable?: true) }

  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end

  describe 'GET #index' do
    it 'returns a successful response with categories' do
      courses = create_list(:course, 3)
      get :index
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data'].size).not_to be_nil
    end

    it 'returns an error response if something goes wrong' do
      allow_any_instance_of(::V1::CourseService).to receive(:get_courses).and_return(nil)
      get :index
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response with a course' do
      course = create(:course)
      get :show, params: { id: course.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['id']).to eq(course.id.to_s)
    end

    it 'returns an error response if course is not found' do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'POST #create' do
    it 'creates a new course and returns a successful response' do
      category = create(:category)
      course_params = { name: 'Test Course', state: 'active', category_id: category.id }
      post :create, params: { course: course_params }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['attributes']['name']).to eq('Test Course')
    end

    it 'returns an error response if creation fails' do
      allow_any_instance_of(::V1::CourseService).to receive(:create_course).and_return([false, nil, ['Error message']])
      post :create, params: { course: {} }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'PATCH #update' do
    it 'updates the course and returns a successful response' do
      course = create(:course)
      update_params = { name: 'Updated Course' }
      patch :update, params: { id: course.id, course: update_params }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['attributes']['name']).to eq('Updated Course')
    end

    it 'returns an error response if update fails' do
      course = create(:course)
      allow_any_instance_of(::V1::CourseService).to receive(:update_course).and_return([false, nil, ['Error message']])
      patch :update, params: { id: course.id, course: {} }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the course and returns a successful response' do
      course = create(:course)
      delete :destroy, params: { id: course.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']['data']['id']).to eq(course.id.to_s)
    end

    it 'returns an error response if deletion fails' do
      course = create(:course)
      allow_any_instance_of(::V1::CourseService).to receive(:destroy_course).and_return(false)
      delete :destroy, params: { id: course.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
