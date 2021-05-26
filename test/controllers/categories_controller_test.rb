require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def login_setup
    @user2 = User.create(firstname: 'Juan', lastname: 'Cruz', username: 'juan2.cruz', email: 'juan2@email.com', password: 'password')
    @user = User.create(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    post login_path, params: {session: {email: 'juan@email.com', password: 'password'}}    
  end
  def create_category
    post categories_path, params: { category: { name: 'Household', description: 'Household chores'}}
  end
  def login_setup_second
    post login_path, params: {session: {email: 'juan2@email.com', password: 'password'}}    
  end
  #show index test
  test 'should not proceed to dashboard if there is no logged in user insted must be redirected back to login page' do 
    get dashboard_path
    assert_response :redirect
  end

  test 'should go to dashboard if there is a logged in user' do 
    login_setup
    get dashboard_path
    assert_response :success
  end

  #new Category test

  test 'should not go to new category page if not logged in' do
    get new_category_path
    assert_response :redirect
  end

  test 'should  go to new category page if p logged in' do
    login_setup
    get new_category_path
    assert_response :success
  end


  #create Category test

  test "should save Category to currently logged on user and redirect to show category" do
    login_setup 
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: 'Household', description: 'Household chores'}}
      assert_response :redirect
    end
  end
 

  # show Category test
  test 'should only open categories that the logged in user has made if not should redirect to dashboard' do
    login_setup
    create_category
    login_setup_second
    get category_path(Category.last)
    
    assert_response :redirect
  end

  test 'should able to access category made by the certain user' do
    login_setup
    create_category

    get category_path(Category.last)
    assert_response :success
  end

  #edit Category test

  test 'should able to access edit category if logged in as owner of current category' do
    login_setup
    create_category
    get edit_category_path(Category.last)

    assert_response :success
  end
  test 'should not be able to access edit page if user is not the category owner' do
    login_setup
    create_category
    login_setup_second
    get edit_category_path(Category.last)

    assert_response :redirect
  end
  #update Category test

  test "should update Category and redirect to category show" do
    login_setup
    create_category
    patch category_update_path(Category.last), params: { category: { name: 'Household', description: 'Household chores version 2'}}
    
    assert_equal('Household chores version 2', Category.last.description)
    assert_response :redirect
  end
 
  
end
