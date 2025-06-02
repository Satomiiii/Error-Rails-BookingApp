# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザー作成
user = User.create!(
  name: 'テスト太郎',
  email: 'test@example.com',
  password: 'password',
  password_confirmation: 'password'
)

# Room 作成（エリアや住所付きで）
Room.create!(
  name: '東京のホテル',
  area: '東京',
  description: 'テスト用のホテルです',
  price: 10000,
  address: '東京都',
  user: user
)

Room.create!(
  name: '大阪の旅館',
  area: '大阪',
  description: '大阪の宿です',
  price: 8000,
  address: '大阪府',
  user: user
)


Room.create!(
  name: "テスト用のホテル",
  area: "東京",
  address: "東京都",
  description: "テストデータです",
  price: 10000,
  user_id: 1
)
