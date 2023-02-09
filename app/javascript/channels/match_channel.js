import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {
  const data = document.getElementById("data")
  if (data === null) { return }
  const match_id = data.getAttribute("data-match-id")
  const game_id = data.getAttribute("data-game-id")

  consumer.subscriptions.create(
    { channel: "MatchChannel", match_id: match_id },
    {
      connected() {
        // Called when the subscription is ready for use on the server
      },
      
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    
      received(data) {
        // MatchChannelのブロードキャストを受け取ったらリロードする
        if (data['change_status']) {
          location.reload(true)
        }
        
        if (data['game_id'] !== Number(game_id)) {
          const opponent_progress = document.getElementById("js-opponent-progress")
          if (opponent_progress === null) return
          opponent_progress.innerHTML = data['progress']
        }
      }
    }
  );
})
