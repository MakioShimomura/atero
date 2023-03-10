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

  const image_upload_form = document.getElementById('js-upload-form')
  if (image_upload_form !== null) {
    const image_upload_image = document.getElementById('js-upload-image')
    const image_label_detection = document.getElementById('js-label-detection')

    image_upload_image.addEventListener("change", () => {
      // 非同期通信するデータの作成
      const formData = new FormData();
      formData.append("image", image_upload_image.files[0]);
      const param = {
        method: "POST",
        body: formData
      }

      // 非同期通信
      fetch('http://[::1]:3000/questions/label_detection', param)
        .then(response => response.json())
        .then(words => {
          words.forEach(word => {
            const element = document.createElement('button');
            element.className = 'btn';
            element.innerText = word;
            element.onclick = (event) => {
              document.getElementById('question_choice_text').value = event.target.innerText
            };
            image_label_detection.appendChild(element);
          })
        });
    });

  }
})
