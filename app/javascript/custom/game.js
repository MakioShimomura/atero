document.addEventListener("turbo:load", function() {
  // TOP画面 対戦モードボタン押下時の処理
  const matchBtn = document.getElementById('js-match-btn')
  if (matchBtn !== null) {
    matchBtn.addEventListener('click', () => {
      document.getElementById('match_name').value = document.getElementById('game_name').value
      document.match_form.submit()
    });
  }

  // 正答画面の正誤判定処理
  const judgmentCorrect = document.getElementById('js-judgment-correct')
  if (judgmentCorrect !== null) {
    const judgmentWrong = document.getElementById('js-judgment-wrong')
    const choicesBtn = document.getElementsByName('question[choice]')
  
    for (let btn of choicesBtn) {
    	btn.addEventListener(`change`, (e) => {
  	    document.getElementById('js-question-image').classList.add('non-blur')
        e.target.value === "true" ? judgmentCorrect.classList.add('active') : judgmentWrong.classList.add('active');
    	  setTimeout(() => { document.answer_form.submit() }, 200)
    	})
    }
  }

  // 問題作成 画像予測処理
  const uploadImage = document.getElementById('js-upload-image')
  if (uploadImage !== null) {
    const labels = document.getElementById('js-label-detection')
    const choiceText = document.getElementById('js-question-choice')

    uploadImage.addEventListener("change", () => {
      choiceText.classList.add('hide')
      while(labels.firstChild) { labels.removeChild(labels.firstChild) }
      const formData = new FormData();
      formData.append("upload_file", uploadImage.files[0]);

      fetch('http://127.0.0.1:3000/questions/label_detection', {
          method: "POST",
          body: formData
      })
        .then(response => response.json())
        .then(words => {
          words.forEach(word => { generateLabel(word) })
          choiceText.classList.remove('hide')
        });
    });

    // 検出したラベルのボタンを生成
    const generateLabel = (text) => {
      const label = document.createElement('button');
      label.className = 'btn';
      label.setAttribute('type', 'button');
      label.innerText = text;
      label.onclick = (event) => {
        document.getElementById('js-choice-text').value = event.target.innerText
      };
      labels.appendChild(label);
    }
  }
})
