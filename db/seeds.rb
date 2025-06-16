# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 既存データを削除
User.destroy_all
Room.destroy_all

puts "===== ユーザーと施設データを初期化しました ====="

# ユーザー作成
user = User.create!(
  name: 'テスト太郎',
  email: 'test@example.com',
  password: 'password',
  password_confirmation: 'password'
)

puts "✅ ユーザーを作成しました（#{user.name}）"

# Room 作成
rooms = [
  {
    name: '東京のホテル',
    area: '東京',
    address: '東京都',
    description: 'テスト用のホテルです',
    price: 10000
  },
  {
    name: '大阪の旅館',
    area: '大阪',
    address: '大阪府',
    description: '大阪の宿です',
    price: 8000
  },
  {
    name: 'テスト用のホテル',
    area: '東京',
    address: '東京都',
    description: 'テストデータです',
    price: 10000
  }
]

rooms.each do |room_data|
  Room.create!(room_data.merge(user: user))
end

puts "✅ Roomデータを #{rooms.count} 件作成しました！"
