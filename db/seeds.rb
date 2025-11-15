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

# フォロー関係
other_user = User.find_or_create_by!(email: ENV.fetch("USER_EMAIL")) do |user|
  user.last_name = "斎藤"
  user.first_name = "久夫"
  user.last_name_kana = "サイトウ"
  user.first_name_kana = "ヒサオ"
  user.phone_number = "09048489696"
  user.username = "ludo"
  user.introduction = "hello japan"
  user.password = ENV.fetch("USER_PASSWORD")
end

# other_userがmanetokuをフォロー
Follow.find_or_create_by!(follower_id: other_user.id, followed_id: manetoku.id)

post = Post.find_or_create_by!(title: "革命的", user_id: manetoku.id) do |p|
  p.category = "交際費"
  p.body = "知らないと損！"
  p.post_image.attach(
    io: File.open("#{Rails.root}/db/fixtures/sample-post3.png"),
    filename: "sample-post3.png"
  )
end

Comment.find_or_create_by!(
  body: "非常にためになった",
  post_id: post.id,
  user_id: other_user.id
)

# 投稿へのいいね
PostLike.find_or_create_by!(user_id: other_user.id, post_id: post.id)

# コメントへのいいね
comment = Comment.find_by(post_id: post.id)
CommentLike.find_or_create_by!(user_id: manetoku.id, comment_id: comment.id)

# レビュー（評価）
Review.find_or_create_by!(
  post_id: post.id,
  user_id: other_user.id,
  star: 4,
  body: "内容がとてもわかりやすかったです！"
)

# 通知(フォローしているユーザーが投稿)
Notification.find_or_create_by!(
  user_id: other_user.id,
  notifiable_type: "Post",
  notifiable_id: post.id,
  read: true
)

puts "seedの実行が完了しました"

