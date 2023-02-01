require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
 test "Smoothly access to Homepage" do
   get root_path
   assert_response :success
   assert_template 'games/new'
  end
end
