require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @game = Game.create

    # no_gameを定義
    @no_game = @game.id + 1
    # 存在しないidになるまでインクリメント
    while Game.exists?(@no_game) do
      @no_game += 1
    end
  end

  test "idがDBに存在しないときはroot_pathにリダイレクト" do
    get game_path(@no_game)
    assert_redirected_to root_path
  end

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
