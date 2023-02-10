document.addEventListener("turbo:load", function() {
  const judgment_correct = document.getElementById('js-judgment-correct')
  
  if (judgment_correct !== null) {
    const judgment_wrong = document.getElementById('js-judgment-wrong')
    const choices_btn = document.getElementsByName('question[choice]')
    const queation_image = document.getElementById('js-question-image')
  
    for (let btn of choices_btn) {
    	btn.addEventListener(`change`, (e) => {
  	    queation_image.classList.add('non-blur')
    	  if (e.target.value === "true") {
      	  judgment_correct.classList.add('active')
    	  } else {
    	    judgment_wrong.classList.add('active')
    	  }
    	  setTimeout(() => {
    	    document.answer_form.submit()
    	  }, 200)
    	})
    }
  }
  

  const match_btn = document.getElementById('js-match-btn')
  if (match_btn !== null) {
    match_btn.addEventListener('click', () => {
      const nickname_textfield = document.getElementById('game_name')
      const match_nickname_textfield = document.getElementById('match_name')
      match_nickname_textfield.value = nickname_textfield.value
      document.match_form.submit()
    });
  }
})
