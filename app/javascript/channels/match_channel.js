import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {
  const data = document.getElementById("data")
  if (data === null) { return }
  const match_id = data.getAttribute("data-match-id")
  const game_id = data.getAttribute("data-game-id")
  const match_status_1 = document.getElementById('js-play-screen-1')
  const match_status_2 = document.getElementById('js-play-screen-2')
  const match_status_3 = document.getElementById('js-play-screen-3')

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
        if (data['status'] === 2 && data['finished_id'] == game_id) {
          location.reload(true)
        } else if (data['status'] === 1) {
          match_status_1.classList.add('hide')
          match_status_2.classList.remove('hide')
        }
      }
    }
  );
})
