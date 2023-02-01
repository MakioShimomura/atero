# 回答済のユーザー
Game.create!(name: "ザッハトルテ",
              question_quantities: 5,
              correct_quantities: 4,
              end_at: Time.zone.now + 1.minutes)
# 回答中のユーザー
Game.create!(name: "回答途中",
              question_quantities: 5,
              correct_quantities: 1)

#回答済のユーザー19人（ランキング用）
19.times do |n|
  name = Faker::Name.name
  finish_time =Time.zone.now + n.minutes
  question_quantities = 5
  answer_quantities = 3
  Game.create!(name: name,
              question_quantities: question_quantities,
              correct_quantities: answer_quantities,
              end_at: finish_time)
end

# 正答からanswer(選択肢)を作成
correct_answers_texts = ["猫", "犬", "パンダ", "キリン", "レッサーパンダ"]
correct_answers_texts.each { |correct_answer_text| Answer.create!(text: correct_answer_text) }

# 正答のモデルからquestionを作成
correct_answers = Answer.all()
correct_answers.each_with_index do |correct_answer, i|
  question = correct_answer.questions.create!(text: "この画像はなんでしょう")
  filename = "question#{i + 1}.jpg"
  image = Magick::ImageList.new("app/assets/images/question/#{filename}")
  image = image.blur_image(50.0, 50.0)
               .quantize(256, Magick::GRAYColorspace)
  image.write("/tmp/#{filename}")
  question.image.attach(io: File.open("/tmp/#{filename}"), filename: filename)
end

# 誤答のanswer(選択肢)を作成
100.times {|i| Answer.create!(text: "誤答#{i}") }
