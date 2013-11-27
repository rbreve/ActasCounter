require 'test_helper'

class ActaControllerTest < ActionController::TestCase
  setup do
    @actum = acta(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:acta)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create actum" do
    assert_difference('Actum.count') do
      post :create, actum: { alianza: @actum.alianza, dc: @actum.dc, liberal: @actum.liberal, libre: @actum.libre, nacional: @actum.nacional, numero: @actum.numero, pac: @actum.pac, pinu: @actum.pinu, ud: @actum.ud, verified: @actum.verified }
    end

    assert_redirected_to actum_path(assigns(:actum))
  end

  test "should show actum" do
    get :show, id: @actum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @actum
    assert_response :success
  end

  test "should update actum" do
    put :update, id: @actum, actum: { alianza: @actum.alianza, dc: @actum.dc, liberal: @actum.liberal, libre: @actum.libre, nacional: @actum.nacional, numero: @actum.numero, pac: @actum.pac, pinu: @actum.pinu, ud: @actum.ud, verified: @actum.verified }
    assert_redirected_to actum_path(assigns(:actum))
  end

  test "should destroy actum" do
    assert_difference('Actum.count', -1) do
      delete :destroy, id: @actum
    end

    assert_redirected_to acta_path
  end
end
