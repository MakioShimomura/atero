# 回答済のユーザー
Game.create!(name: "ザッハトルテ",
              question_quantities: 5,
              correct_quantities: 4,
              end_at: Time.zone.now + 1.minutes)
# 回答中のユーザー
Game.create!(name: "回答途中",
              question_quantities: 5,
              correct_quantities: 1)
              
Game.create!(name: "はなまる満点",
              question_quantities: 4,
              correct_quantities: 4,
              end_at: Time.zone.now + 1.minutes)

#回答済、正答率が60%のユーザー9人（ランキング用）
9.times do |n|
  name = "60%#{n}"
  finish_time =Time.zone.now + n.minutes
  question_quantities = 5
  correct_quantities = 3
  Game.create!(name: name,
              question_quantities: question_quantities,
              correct_quantities: correct_quantities,
              end_at: finish_time)
end

Admin.create!(email: "sonic_garden@camp.jp",
              password:               "foobar",
              password_confirmation: "foobar")

#回答済、正答率が40%のユーザー9人（ランキング用）
9.times do |n|
  name = "40%#{n}"
  finish_time =Time.zone.now + n.minutes
  question_quantities = 5
  correct_quantities = 2
  Game.create!(name: name,
              question_quantities: question_quantities,
              correct_quantities: correct_quantities,
              end_at: finish_time)
end

# 正答からchoice(選択肢)を作成
correct_choices_texts = ["ネコ","イヌ","パンダ","キリン","レッサーパンダ","ネコ","マーラ","オカピー"]
correct_choices_texts.each { |correct_choice_text| Choice.create!(text: correct_choice_text) }

# 正答のモデルからquestionを作成
correct_choices = Choice.all()
correct_choices.each_with_index do |correct_choice, i|
  question = correct_choice.questions.create!(text: "この画像はなんでしょう")
  filename = "question#{i + 1}"
  # /tmpに画像を格納
  target_image = Magick::ImageList.new("app/assets/images/question/#{filename}.jpg")
  target_image.blur_image(50.0, 50.0)
              .write("/tmp/#{filename}_blur.jpg")
              .quantize(256, Magick::GRAYColorspace)
              .write("/tmp/#{filename}_monochrome.jpg")
  # active storageに保存
  question.images.attach(io: File.open("/tmp/#{filename}_monochrome.jpg"), filename: "#{filename}_monochrome.jpg")
  question.images.attach(io: File.open("/tmp/#{filename}_blur.jpg"), filename: "#{filename}_blur.jpg")
  question.images.attach(io: File.open("app/assets/images/question/#{filename}.jpg"), filename: "#{filename}_original.jpg")
end

# choice（animal名）作成
99.times do |n|
  text  = Faker::Creature::Animal.name
  Choice.create!(text:  text)
end