require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should return login page' do
    get login_path

    assert_response :success
  end

  test 'should create a new session id and redirect to dashboard' do
    user = User.new(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    user.save
    post login_path, params: {session:{email: 'juan@email.com', password: 'password'}}

    assert_response :redirect              
                                                                                                                                                                    
  end


end
