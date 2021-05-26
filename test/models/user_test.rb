require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'should not save User without firstname' do
    user = User.new(lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    assert_not user.save, 'Save the user without firstname'
  end

  test 'should not save User without lastname' do
    user = User.new(firstname: 'Juan', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    assert_not user.save, 'Save the user without lastname'
  end

  test 'should not save User without email' do
    user = User.new(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', password: 'password')
    assert_not user.save, 'Save the user without email'
  end

  test 'should not save User without password' do
    user = User.new(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com')
    assert_not user.save, 'Save the user without password'
  end

  test 'should not save if email is invalid' do
    user = User.new(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juanemail.com', password: 'password')
    assert_not user.save, 'Save the user with invalid email address'
  end

  test 'should not save if username already exist' do
    user = User.new(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    user.save
    user2 = User.new(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan2@email.com', password: 'password')

    assert_not user2.save, 'Save the user with existing username'
  end

  test 'should not save if email already exist' do
    user = User.new(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    user.save
    user2 = User.new(firstname: 'Juan', lastname: 'Cruz', username: 'juan2.cruz', email: 'juan@email.com', password: 'password')

    assert_not user2.save, 'Save the user with existing email'
  end


end
