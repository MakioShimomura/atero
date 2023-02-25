require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @game = Game.new
  end

  test "ホームページへアクセス" do
    get root_path
    assert_response :success
    assert_template 'games/new'
  end

  test "ゲームユーザーの名前は20文字以内" do
    @game.name = "a"* 21
    assert_not @game.valid?
  end
end
