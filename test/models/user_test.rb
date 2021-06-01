require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'should not save User without firstname' do
    @user.firstname = nil
    assert_not @user.valid?, 'Save the user without firstname'
  end

  test 'should not save User without lastname' do
    @user.lastname = nil
    assert_not @user.save, 'Save the user without lastname'
  end

  test 'should not save User without email' do
    @user.email = nil
    assert_not @user.save, 'Save the user without email'
  end

  test 'should not save User without password' do
    @user.password = nil
    assert_not @user.save, 'Save the user without password'
  end

  test 'should not save if email is invalid' do
    @user.email = 'juanemail.com'
    assert_not @user.save, 'Save the user with invalid email address'
  end
  test 'should not save if email already exist' do
    @user.save
    @user2 = @user.dup
    @user2.username = 'juan1.cruz' 
    assert_not @user2.save, 'Save the user with existing username'
  end


end
