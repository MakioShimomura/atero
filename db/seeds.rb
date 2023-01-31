current = Time.zone.now
# 回答済のユーザー
Result.create!(name: "ザッハトルテ",
              question_quantities: 5,
              answer_quantities: 4,
              start_time: current,
              finish_time: current + 1.minutes)
# 回答中のユーザー
Result.create!(name: "回答途中",
              question_quantities: 5,
              answer_quantities: 1,
              start_time: current
)


# 正答からanswer(選択肢)を作成
correct_answers_texts = ["猫", "犬", "猿"]
correct_answers_texts.each { |correct_answer_text| Answer.create!(text: correct_answer_text) }

# 正答のモデルからquestionを作成
correct_answers = Answer.all()
correct_answers.each { |correct_answer| correct_answer.questions.create!(text: "この画像はなんでしょう") }

# 誤答のanswer(選択肢)を作成
10.times { Answer.create!(text: "誤答テキスト") }