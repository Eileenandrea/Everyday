require "test_helper"

class TaskTest < ActiveSupport::TestCase
  #create username and category and create a task template
  def setup 
    @user = User.create(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    @category = Category.create(name: 'work', description: 'work stuff',user: @user )
    @task = Task.new(name: 'cook dinner', description: 'Cook Pancit canton for dinner',due_date: 'Thu, 27 May 2021 03:03:52.977063000 UTC +00:00', category: @category)
  end

  test 'valid task' do
    assert @task.valid?
  end

  test 'should not save without task name' do
    @task.name = nil
    assert_not @task.save
  end

  test 'should not save wihout category-id' do 
    @task.category = nil
    assert_not @task.save
  end

end
