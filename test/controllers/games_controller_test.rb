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
  
  test "ゲームユーザー登録" do
    get root_path
    assert_difference "Game.count", 1 do
      post games_path, params: { game: {name: "hoge"} }
    end
    assert_response :redirect
  end
end
