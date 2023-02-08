document.addEventListener("turbo:load", function() {
  const judgment = document.getElementById('js-judgment')
  if (judgment === null) { return }
  const choices_btn = document.getElementsByName('question[choice]')
  const queation_image = document.getElementById('js-question-image')

  for (let btn of choices_btn) {
  	btn.addEventListener(`change`, (e) => {
	    queation_image.classList.add('non-blur')
  	  if (e.target.value === "true") {
    	  judgment.classList.add('correct')
  	  } else {
  	    judgment.classList.add('wrong')
  	  }
  	  setTimeout(() => {
  	    document.answer_form.submit()
  	  }, 200)
  	})
  }
})
