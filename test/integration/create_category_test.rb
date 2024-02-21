require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    # @category = Category.create(name: "Sports")
    @admin_user = User.create(username: "Admin User", email: "adminuser@example.com", password: "password", admin: true)
    sign_in_as(@admin_user)
  end

  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params: {category: {name: "Sports"} }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end


test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: {category: {name: " "} }
      # assert_response :redirect/ no need for following or asserting response
    end

    # follow_redirect!  
    assert_match "Following errors stopped you from proceeding", response.body
    assert_select 'h1'
  end
end
