require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @user = User.create(firstname: 'Juan', lastname: 'Cruz', username: 'juan.cruz', email: 'juan@email.com', password: 'password')
    
    @category = Category.new(name: 'work', description: 'work stuff',user: @user )
  end
  test 'valid category' do 
    assert @category.valid?
  end
  test 'should not save category without name' do
    @category.name = nil
    assert_not @category.save
  end
  
  test 'should not save category without uid' do
    @category.user = nil
    assert_not @category.valid?
  end

end
