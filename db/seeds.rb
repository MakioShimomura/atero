Admin.create!(email: "sonic_garden@camp.jp",
              password:               "foobar",
              password_confirmation: "foobar")
              
# 回答済みのユーザー
base_at = Time.zone.now + 30.second
names = ["みっちゃん", "ふく", "うの", "まっきー"]
names.each.with_index(1) do |name, i|
  Game.create!(name: name,
               question_quantities: 4,
               correct_quantities: 2,
               end_at: base_at + i.second)
end
# 同率のユーザー
2.times do
  Game.create!(name: "同率くん",
             question_quantities: 4,
             correct_quantities: 2,
             end_at: base_at + 10.second)
end
# 最下位のユーザー
Game.create!(name: "最下位くん",
             question_quantities: 4,
             correct_quantities: 0,
             end_at: base_at + 10.second)

# 正答からchoice(選択肢)を作成
correct_choices_texts = ["ネコ","イヌ","パンダ","キリン","レッサーパンダ","ネコ","マーラ","オカピー"]
correct_choices_texts.each { |correct_choice_text| Choice.create!(text: correct_choice_text) }

# 正答のモデルからquestionを作成
correct_choices = Choice.all()
correct_choices.each_with_index do |correct_choice, i|
  question = correct_choice.questions.create!(text: "この画像はなんでしょう")
  filename = "question#{i + 1}"
  question.image.attach(io: File.open("app/assets/images/question/#{filename}.jpg"), filename: "#{filename}.jpg")
end

# choice（animal名）作成
99.times do |n|
  text  = Faker::Creature::Animal.name
  Choice.create!(text:  text)
end