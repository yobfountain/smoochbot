require 'test_helper'

class SmoocheesControllerTest < ActionController::TestCase
  setup do
    @smoochee = smoochees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:smoochees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create smoochee" do
    assert_difference('Smoochee.count') do
      post :create, :smoochee => @smoochee.attributes
    end

    assert_redirected_to smoochee_path(assigns(:smoochee))
  end

  test "should show smoochee" do
    get :show, :id => @smoochee.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @smoochee.to_param
    assert_response :success
  end

  test "should update smoochee" do
    put :update, :id => @smoochee.to_param, :smoochee => @smoochee.attributes
    assert_redirected_to smoochee_path(assigns(:smoochee))
  end

  test "should destroy smoochee" do
    assert_difference('Smoochee.count', -1) do
      delete :destroy, :id => @smoochee.to_param
    end

    assert_redirected_to smoochees_path
  end
end
