# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#1stデプロイのテスト内容
puts "seedの実行を開始"

Admin.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = ENV.fetch("ADMIN_PASSWORD")
  admin.password_confirmation = ENV.fetch("ADMIN_PASSWORD")
end

messhi = User.find_or_create_by!(email: "messhi@example.com") do |user|
  user.last_name = "加藤"
  user.first_name = "良子"
  user.last_name_kana = "カトウ"
  user.first_name_kana = "ヨシコ"
  user.phone_number = "09014725836"
  user.username = "messhi"
  user.introduction = "hello world"
  user.password = "password123"
  user.profile_image.attach(
    io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"),
    filename: "sample-user3.jpg"
  )
end

post = Post.find_or_create_by!(title: "一押しの節約術", user_id: messhi.id) do |p|
  p.category = "交通費"
  p.body = "ぜひ試してみてください！"
  p.post_image.attach(
    io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"),
    filename: "sample-post3.jpg"
  )
end


puts "seedの実行が完了しました"

Comment.find_or_create_by!(
  body: "とても参考になりました。",
  post_id: post.id,
  user_id: messhi.id
)

period = Period.find_or_create_by!(
  start_date: Date.new(2025,10,24),
  end_date: Date.new(2025,10,25),
  user_id: messhi.id
)

category = Category.find_or_create_by!(
  category_name: "交通費",
  budget: 15000,
  user_id: messhi.id,
  period_id: period.id
)

Expense.find_or_create_by!(
  amount: 700,
  expense_date: Date.new(2025,10,24),
  user_id: messhi.id,
  period_id: period.id,
  category_id: category.id
)
puts "seedの実行が完了しました"

