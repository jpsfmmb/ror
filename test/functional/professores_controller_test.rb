require 'test_helper'

class ProfessoresControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:professores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create professore" do
    assert_difference('Professore.count') do
      post :create, :professore => { }
    end

    assert_redirected_to professore_path(assigns(:professore))
  end

  test "should show professore" do
    get :show, :id => professores(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => professores(:one).to_param
    assert_response :success
  end

  test "should update professore" do
    put :update, :id => professores(:one).to_param, :professore => { }
    assert_redirected_to professore_path(assigns(:professore))
  end

  test "should destroy professore" do
    assert_difference('Professore.count', -1) do
      delete :destroy, :id => professores(:one).to_param
    end

    assert_redirected_to professores_path
  end
end
