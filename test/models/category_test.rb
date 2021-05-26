require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test 'should not save category without name' do
      category = Category.new
      category.description = 'Task Category description'

      assert_not category.save
  end

end
