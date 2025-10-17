# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"

Admin.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = ENV.fetch("ADMIN_PASSWORD")
  admin.password_confirmation = ENV.fetch("ADMIN_PASSWORD")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.last_name = "佐藤"
  user.first_name = "道子"
  user.last_name_kana = "サトウ"
  user.first_name_kana = "ミチコ"
  user.phone_number = "09098765432"
  user.username = "Lucas"
  user.introduction = "hello"
  user.password = "password1"
  user.profile_image.attach(
    io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"),
    filename: "sample-user3.jpg"
  )
end

Post.find_or_create_by!(title: "節約術") do |post|
  post.body = "自慢の節約術"
  post.post_image.attach(
    io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"),
    filename: "sample-post3.jpg"
  )
  post.user = lucas
end

puts "seedの実行が完了しました"