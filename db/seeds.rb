# 回答済のユーザー
Game.create!(name: "ザッハトルテ",
              question_quantities: 5,
              answer_quantities: 4,
              finish_time: Time.zone.now + 1.minutes)
# 回答中のユーザー
Game.create!(name: "回答途中",
              question_quantities: 5,
              answer_quantities: 1)


# 正答からanswer(選択肢)を作成
correct_answers_texts = ["猫", "犬", "パンダ"]
correct_answers_texts.each { |correct_answer_text| Answer.create!(text: correct_answer_text) }

# 正答のモデルからquestionを作成
correct_answers = Answer.all()
correct_answers.each_with_index do |correct_answer, i|
  question = correct_answer.questions.create!(text: "この画像はなんでしょう")
  filename = "question#{i + 1}.jpg"
  question.image.attach(io: File.open(Rails.root.join("app/assets/images/question/#{filename}")), filename: filename)
end

# 誤答のanswer(選択肢)を作成
100.times {|i| Answer.create!(text: "誤答#{i}") }
