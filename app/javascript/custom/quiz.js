document.addEventListener("turbo:load", function() {
  let judgment = document.getElementById('judgment')
  let choices_btn = document.getElementsByName('question[choice]')
  
  for (let choice_btn of choices_btn) {
  	choice_btn.addEventListener(`change`, (e) => {
  	  if (e.target.value === "true") {
    	  judgment.classList.add('correct')
  	  } else {
  	    judgment.classList.add('wrong')
  	  }
  	  setTimeout(() => {
  	    document.myform.submit()
  	  }, 200)
  	})
  }
})
