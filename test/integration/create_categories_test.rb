require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

	test "get new category form and create category" do 
		get new_category_path
		assert_template "categories/new"	# new form
		assert_difference "Category.count", 1 do  # check the difference by one
			post_via_redirect categories_path, category: {name: "sports"} # posting to the new form
		end

	assert_template "categories/index"
	assert_match "sports", response.body

	end


end