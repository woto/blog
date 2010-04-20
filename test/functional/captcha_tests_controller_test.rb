require 'test_helper'

class CaptchaTestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:captcha_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create captcha_test" do
    assert_difference('CaptchaTest.count') do
      post :create, :captcha_test => { }
    end

    assert_redirected_to captcha_test_path(assigns(:captcha_test))
  end

  test "should show captcha_test" do
    get :show, :id => captcha_tests(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => captcha_tests(:one).to_param
    assert_response :success
  end

  test "should update captcha_test" do
    put :update, :id => captcha_tests(:one).to_param, :captcha_test => { }
    assert_redirected_to captcha_test_path(assigns(:captcha_test))
  end

  test "should destroy captcha_test" do
    assert_difference('CaptchaTest.count', -1) do
      delete :destroy, :id => captcha_tests(:one).to_param
    end

    assert_redirected_to captcha_tests_path
  end
end
