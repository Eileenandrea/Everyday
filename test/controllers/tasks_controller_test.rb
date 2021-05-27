require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end


  def create_category
    @user = User.create(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    post login_path, params: {session: {email: 'juan@email.com', password: 'password'}}    
    post categories_path, params: { category: { name: 'Household', description: 'Household chores'}}
  end

  def log_second_user #this create a second user and logged the second user
    delete logout_path
    @user2 = User.create(firstname: 'Juan', lastname: 'Cruz', username: 'juan2.cruz', email: 'juan2@email.com', password: 'password')
    post login_path, params: {session: {email: 'juan2@email.com', password: 'password'}}    
  end
  #task index
  test 'should not go to tasks list if there is no logged in user' do
      create_category
      delete logout_path
      get category_tasks_path(Category.last)

      assert_response :redirect
  end

  test 'should not go to taks list if logged in user is not the owner of the task category' do
    create_category
    log_second_user
    get category_tasks_path(Category.last)
    
    assert_response :redirect
  end

  test 'should able to access task list if logged in user is the owner' do
    create_category
    get category_tasks_path(Category.last)

    assert_response :success
  end


  #new task

  test 'should not be able to create new task if not logged on' do
    create_category
    delete logout_path
    get new_category_task_path(Category.last)

    assert_response :redirect
  end
  
  test 'should not be able to create task under category that the logged user does not make' do
    create_category
    log_second_user
    get new_category_task_path(Category.last)
    
    assert_response :redirect
  end

  test 'should be able to create task if current category is owned by the logged in user' do
    create_category
    get new_category_task_path(Category.last)

    assert_response :success
  end

  #create task

  test 'should be able to create task under the category and must redirect to show path' do
    create_category
    assert_difference 'Task.count', 1 do
      post category_tasks_path(Category.last), params: { task: { name: 'clean', description: 'clean bathroom', due_date: 'Thu, 27 May 2021 08:25:49.737707000 UTC +00:00'}}
      assert_response :redirect
    end
  end

  #show task test
  test 'should be able to view task if correct user and category id' do
    create_category
    post category_tasks_path(Category.last), params: { task: { name: 'clean', description: 'clean bathroom', due_date: 'Thu, 27 May 2021 08:25:49.737707000 UTC +00:00'}}
    get category_task_path(id:Task.last)
    assert_response :success
  end

  test 'should not be able to access task if category_id does not match task category_id' do
    create_category
    log_second_user
    post category_tasks_path(Category.last), params: { task: { name: 'clean', description: 'clean bathroom', due_date: 'Thu, 27 May 2021 08:25:49.737707000 UTC +00:00'}}
    get category_task_path(category_id:1,id:Task.last)
    assert_response :redirect
  end


  #edit task test
  
  test 'should not be able to edit new task if not logged on' do
    create_category
    post category_tasks_path(Category.last), params: { task: { name: 'clean', description: 'clean bathroom', due_date: 'Thu, 27 May 2021 08:25:49.737707000 UTC +00:00'}}

    delete logout_path
    get edit_category_task_path(category_id:Category.last, id:Task.last)

    assert_response :redirect
  end
  
  test 'should not be able to edit task under category that the logged user does not make' do
    create_category
    post category_tasks_path(Category.last), params: { task: { name: 'clean', description: 'clean bathroom', due_date: 'Thu, 27 May 2021 08:25:49.737707000 UTC +00:00'}}
    log_second_user
    get edit_category_task_path(category_id:Category.last, id:Task.last)
    
    assert_response :redirect
  end

  test 'should be able to edit task if current category is owned by the logged in user' do
    create_category
    post category_tasks_path(Category.last), params: { task: { name: 'clean', description: 'clean bathroom', due_date: 'Thu, 27 May 2021 08:25:49.737707000 UTC +00:00'}}
    get edit_category_task_path(category_id:Category.last, id:Task.last)

    assert_response :success
  end

  #update task test
  test 'should be able to edit task under the category and must redirect to show path' do
    create_category
      post category_tasks_path(Category.last), params: { task: { name: 'clean', description: 'clean bathroom', due_date: 'Thu, 27 May 2021 08:25:49.737707000 UTC +00:00'}}
      patch category_task_path(category_id:Category.last,id:Task.last), params: { task: { name: 'clean now', description: 'clean bathroom', due_date: 'Thu, 27 May 2021 08:25:49.737707000 UTC +00:00'}}
      assert_equal('clean now', Task.last.name)
      assert_response :redirect
  end

  #delete task test
  test 'should be able to delete task' do
    create_category
    post category_tasks_path(Category.last), params: { task: { name: 'clean', description: 'clean bathroom', due_date: 'Thu, 27 May 2021 08:25:49.737707000 UTC +00:00'}}
    
    assert_difference 'Task.count', -1 do
      delete category_task_path(category_id:Category.last,id:Task.last)
    end
    assert_response :redirect
  end


end
