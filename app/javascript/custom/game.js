document.addEventListener("turbo:load", function() {
  let judgment = document.getElementById('judgment')
  if (judgment === null) { return }
  let choices_btn = document.getElementsByName('question[choice]')
  
  let question_image_0 = document.getElementById('question-image-0')
  let question_image_1 = document.getElementById('question-image-1')
  let question_image_2 = document.getElementById('question-image-2')
  
  // 画像切り替えロジック
  setTimeout(() => {
    question_image_0.classList.remove('active')
    question_image_1.classList.add('active')
  }, 2000)
  
  for (let choice_btn of choices_btn) {
  	choice_btn.addEventListener(`change`, (e) => {
  	  if (e.target.value === "true") {
    	  judgment.classList.add('correct')
  	  } else {
  	    judgment.classList.add('wrong')
  	  }
  	  question_image_0.classList.remove('active')
  	  question_image_1.classList.remove('active')
  	  question_image_2.classList.add('active')
  	  setTimeout(() => {
  	    document.myform.submit()
  	  }, 200)
  	})
  }
})
