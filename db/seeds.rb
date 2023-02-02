# 回答済のユーザー
Game.create!(name: "ザッハトルテ",
              question_quantities: 5,
              correct_quantities: 4,
              end_at: Time.zone.now + 1.minutes)
# 回答中のユーザー
Game.create!(name: "回答途中",
              question_quantities: 5,
              correct_quantities: 1)

#回答済、正答率が60%のユーザー9人（ランキング用）
9.times do |n|
  name = Faker::Name.name
  finish_time =Time.zone.now + n.minutes
  question_quantities = 5
  correct_quantities = 3
  Game.create!(name: name,
              question_quantities: question_quantities,
              correct_quantities: correct_quantities,
              end_at: finish_time)
end

#回答済、正答率が40%のユーザー9人（ランキング用）
9.times do |n|
  name = Faker::Name.name
  finish_time =Time.zone.now + n.minutes
  question_quantities = 5
  correct_quantities = 2
  Game.create!(name: name,
              question_quantities: question_quantities,
              correct_quantities: correct_quantities,
              end_at: finish_time)
end

# 正答からchoice(選択肢)を作成
correct_choices_texts = ["猫", "犬", "パンダ", "キリン", "レッサーパンダ"]
correct_choices_texts.each { |correct_choice_text| Choice.create!(text: correct_choice_text) }

# 正答のモデルからquestionを作成
correct_choices = Choice.all()
correct_choices.each_with_index do |correct_choice, i|
  question = correct_choice.questions.create!(text: "この画像はなんでしょう")
  filename = "question#{i + 1}.jpg"
  image = Magick::ImageList.new("app/assets/images/question/#{filename}")
  image = image.blur_image(50.0, 50.0)
               .quantize(256, Magick::GRAYColorspace)
  image.write("/tmp/#{filename}")
  question.image.attach(io: File.open("/tmp/#{filename}"), filename: filename)
end

# 誤答のchoice(選択肢)を作成
200.times {|i| Choice.create!(text: "誤答#{i}") }
