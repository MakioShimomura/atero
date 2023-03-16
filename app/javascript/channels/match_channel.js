import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {
  const data = document.getElementById("js-match-data")
  if (data === null) { return }
  const MatchId = data.getAttribute("data-match-id")
  const GameId = data.getAttribute("data-game-id")

  consumer.subscriptions.create(
    { channel: "MatchChannel", match_id: MatchId },
    {
      connected() {
      },
      
      disconnected() {
      },
    
      received(data) {
        // Matchのステータスが変更されたらリロードする
        if (data['change_status']) {
          location.reload(true)
        }

        // 対戦相手の進行状況を更新
        if (data['game_id'] !== Number(GameId)) {
          document.getElementById("js-opponent-progress").innerHTML = data['progress']
        }
      }
    }
  );
})
