require 'test_helper'

class DisciplinaProfessoresControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:disciplina_professores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create disciplina_professore" do
    assert_difference('DisciplinaProfessore.count') do
      post :create, :disciplina_professore => { }
    end

    assert_redirected_to disciplina_professore_path(assigns(:disciplina_professore))
  end

  test "should show disciplina_professore" do
    get :show, :id => disciplina_professores(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => disciplina_professores(:one).to_param
    assert_response :success
  end

  test "should update disciplina_professore" do
    put :update, :id => disciplina_professores(:one).to_param, :disciplina_professore => { }
    assert_redirected_to disciplina_professore_path(assigns(:disciplina_professore))
  end

  test "should destroy disciplina_professore" do
    assert_difference('DisciplinaProfessore.count', -1) do
      delete :destroy, :id => disciplina_professores(:one).to_param
    end

    assert_redirected_to disciplina_professores_path
  end
end
