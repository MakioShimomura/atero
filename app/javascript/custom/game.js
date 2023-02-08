document.addEventListener("turbo:load", function() {
  let judgment = document.getElementById('js-judgment')
  if (judgment === null) { return }
  let choices_btn = document.getElementsByName('question[choice]')

  for (let btn of choices_btn) {
  	btn.addEventListener(`change`, (e) => {
  	  if (e.target.value === "true") {
    	  judgment.classList.add('correct')
  	  } else {
  	    judgment.classList.add('wrong')
  	  }
  	  setTimeout(() => { document.answer_form.submit() }, 200)
  	})
  }
})
