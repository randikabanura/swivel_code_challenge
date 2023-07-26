require "test_helper"

class Api::V1::VerticalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vertical = verticals(:one)
  end

  test "should get index" do
    get api_v1_verticals_url, as: :json
    assert_response :success
  end

  test "should create vertical" do
    assert_difference("Vertical.count") do
      post api_v1_verticals_url, params: { vertical: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show vertical" do
    get api_v1_vertical_url(@vertical), as: :json
    assert_response :success
  end

  test "should update vertical" do
    patch api_v1_vertical_url(@vertical), params: { vertical: {  } }, as: :json
    assert_response :success
  end

  test "should destroy vertical" do
    assert_difference("Vertical.count", -1) do
      delete api_v1_vertical_url(@vertical), as: :json
    end

    assert_response :no_content
  end
end
