require "test_helper"

class MatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get play" do
    get matches_play_url
    assert_response :success
  end

  test "should get result" do
    get matches_result_url
    assert_response :success
  end
end
