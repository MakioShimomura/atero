require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest

  def setup
    # 失敗用のユーザー
    @game = Game.new

    @create_game = Game.create

    # no_gameを定義
    @no_game = @create_game.id + 1
    # 存在しないidになるまでインクリメント
    while Game.exists?(@no_game) do
      @no_game += 1
    end
  end

  test "idがDBに存在しないときはroot_pathにリダイレクト" do
    get game_path(@no_game)
    assert_redirected_to root_path
  end

  test "ホームページへアクセス" do
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

  test "ゲームユーザーの名前は20文字以内" do
    @game.name = "a"* 21
    assert_not @game.valid?
  end
end
