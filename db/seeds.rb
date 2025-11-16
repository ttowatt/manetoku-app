# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"

Admin.find_or_create_by!(email: ENV.fetch("ADMIN_EMAIL")) do |admin|
  admin.password = ENV.fetch("ADMIN_PASSWORD")
  admin.password_confirmation = ENV.fetch("ADMIN_PASSWORD")
end

manetoku = User.find_or_create_by!(email: ENV.fetch("PUBLIC_EMAIL")) do |user|
  user.last_name = "田中"
  user.first_name = "和"
  user.last_name_kana = "タナカ"
  user.first_name_kana = "カズ"
  user.phone_number = "09087654321"
  user.username = "manetoku"
  user.introduction = "hello manetoku"
  user.password = ENV.fetch("PUBLIC_PASSWORD")
  user.profile_image.attach(
    io: File.open("#{Rails.root}/db/fixtures/sample-user3.png"),
    filename: "sample-user3.png"
  )
end

ludo = User.find_or_create_by!(email: ENV.fetch("USER_EMAIL")) do |user|
  user.last_name = "斎藤"
  user.first_name = "久夫"
  user.last_name_kana = "サイトウ"
  user.first_name_kana = "ヒサオ"
  user.phone_number = "09048489696"
  user.username = "ludo"
  user.introduction = "hello japan"
  user.password = ENV.fetch("USER_PASSWORD")
  user.profile_image.attach(
    io: File.open("#{Rails.root}/db/fixtures/sample-user4.png"),
    filename: "sample-user4.png"
  )
end

period = Period.find_or_create_by!(
  start_date: Date.new(2025,10,26),
  end_date: Date.new(2025,10,27),
  user_id: manetoku.id
)

category = Category.find_or_create_by!(
  category_name: "通信費",
  budget: 18000,
  user_id: manetoku.id,
  period_id: period.id
)

Expense.find_or_create_by!(
  amount: 900,
  expense_date: Date.new(2025,10,27),
  user_id: manetoku.id,
  period_id: period.id,
  category_id: category.id
)

# ludoがmanetokuをフォロー
Follow.find_or_create_by!(follower_id: ludo.id, followed_id: manetoku.id)

# manetokuがludoフォロー
Follow.find_or_create_by!(follower_id: manetoku.id, followed_id: ludo.id)

manetoku_post = Post.find_or_create_by!(title: "革命的", user_id: manetoku.id) do |p|
  p.category = "交際費"
  p.body = "知らないと損！"
  p.post_image.attach(
    io: File.open("#{Rails.root}/db/fixtures/sample-post3.png"),
    filename: "sample-post3.png"
  )
end

ludo_post = Post.find_or_create_by!(title: "有料級", user_id: ludo.id) do |p|
  p.category = "食費"
  p.body = "ぜひ試してほしいです！"
  p.post_image.attach(
    io: File.open("#{Rails.root}/db/fixtures/sample-post4.png"),
    filename: "sample-post4.png"
  )
end

# ludoがmanetokuの投稿へコメント
ludo_comment = Comment.find_or_create_by!(
  body: "非常にためになった",
  post_id: manetoku_post.id,
  user_id: ludo.id
)

# コメントへのいいね
comment = Comment.find_by(post_id: manetoku_post.id)
CommentLike.find_or_create_by!(user_id: manetoku.id, comment_id: ludo_comment.id)

# manetokuがludoの投稿へいいね
PostLike.find_or_create_by!(user_id: manetoku.id, post_id: ludo_post.id)

# ludoがmanetokuの投稿へいいね
PostLike.find_or_create_by!(user_id: ludo.id, post_id: manetoku_post.id)

# manetokuがludoの投稿へレビュー（評価）
Review.find_or_create_by!(
  post_id: ludo_post.id,
  user_id: manetoku.id,
  star: 4,
  body: "内容がとてもわかりやすかったです！"
)

# ludoがmanetokuの投稿へレビュー（評価）
Review.find_or_create_by!(
  post_id: manetoku_post.id,
  user_id: ludo.id,
  star: 5,
  body: "ほかの人にも共有します！"
)

# manetokuが投稿したらludoに通知
Notification.find_or_create_by!(
  user_id: ludo.id,
  notifiable_type: "Post",
  notifiable_id: manetoku_post.id,
  read: true
)

# ludoが投稿したらmanetokuに通知
Notification.find_or_create_by!(
  user_id: manetoku.id,
  notifiable_type: "Post",
  notifiable_id: ludo_post.id,
  read: true
)

puts "seedの実行が完了しました"

