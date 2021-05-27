require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should return login page' do
    get login_path

    assert_response :success
  end

  test 'should create a new session id and redirect to dashboard' do
    user = User.create(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    post login_path, params: {session:{email: 'juan@email.com', password: 'password'}}
    
    assert_response :redirect              
                                                                                                                                                                    
  end

  test 'should logout user and redirect to root_path' do

    user = User.create(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    post login_path, params: {session:{email: 'juan@email.com', password: 'password'}}

    delete logout_path
    assert_equal(nil,session[:user_id])
    assert_response :redirect
  end


end
