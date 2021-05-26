require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'return sign up page' do
    get signup_path

    assert_response :success
  end

  test 'should create user' do
    post users_path, params: { user: { firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password1'}}

    assert_response :redirect
  end
end
