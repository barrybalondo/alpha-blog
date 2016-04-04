require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create(username: "barry", email: "barry@testing.com", password: "password", admin: true)
	end

	test "get new category form and create category" do 
		sign_in_as(@user, "password")
		get new_category_path
		assert_template "categories/new"	# new form
		assert_difference "Category.count", 1 do  # check the difference by one
			post_via_redirect categories_path, category: {name: "sports"} # posting to the new form
		end

		assert_template "categories/index"
		assert_match "sports", response.body

	end

	test "invalid category submission results in failure" do
		sign_in_as(@user, "password")

		get new_category_path
		assert_template "categories/new"	# new form
		assert_no_difference "Category.count" do  # check the difference by one
			post categories_path, category: {name: " "} # posting to the new form
		end

		assert_template "categories/new"
		assert_select "h2.panel-title" #reference to the existen of the error in the forms using the class
		assert_select "div.panel-body"

	end

end