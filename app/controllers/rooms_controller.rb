class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  

  def tokyo_index
  # 東京エリアの施設一覧を取得、デフォルトでプリンスホテルを含める
    @rooms = Room.where(area: '東京')
    if @rooms.empty?
      @rooms = [Room.create!(
        name: 'プリンスホテル',
        area: '東京',
        address: '東京都港区',
        description: '添い寝用のお布団やおまる、ベビーチェア、お子様ハンガー、コンセントキャップ、離乳食などを備えた赤ちゃん専用ルームです。ご家族でゆっくりお過ごしください。',
        price: 18000
      )]
    end
  end



  def osaka_index
    @rooms = Room.where(area: '大阪')
    #puts "大阪の施設一覧: #{@rooms.inspect}" # デバッグ用出力
    if @rooms.empty?
      @rooms = [Room.create!(
        name: 'ホテルニューガイア',
        area: '大阪',
        description: '添い寝用のお布団やおまる、ベビーチェア、お子様ハンガー、コンセントキャップ、離乳食などを備えた赤ちゃん専用ルームです。ご家族でゆっくりお過ごしください。',
        price: 18000
      )]
      #puts "デフォルト施設を作成しました: #{@rooms.inspect}" # デバッグ用出力
    end
  end
    

  def kyoto_index
    @rooms = Room.where(area: '京都')
    if @rooms.empty?
      @rooms = [Room.create(name: '湯快リゾート', area: '京都府', description: '添い寝用のお布団やおまる、ベビーチェア、お子様ハンガー、コンセントキャップ、離乳食などを備えた赤ちゃん専用ルームです。ご家族でゆっくりお過ごしください。', price: 18000)]
    end
  end
  
  def sapporo_index
    @rooms = Room.where(area: '札幌')
    if @rooms.empty?
      @rooms = [Room.create(name: '東急ステイ', area: '札幌', description: '添い寝用のお布団やおまる、ベビーチェア、お子様ハンガー、コンセントキャップ、離乳食などを備えた赤ちゃん専用ルームです。ご家族でゆっくりお過ごしください。', price: 18000)]
    end
  end
  
  




  def new
     @room = Room.new
     @reservation = Reservation.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    #@room = Room.new(room_params)
    if @room.save
      redirect_to rooms_path, notice: '施設が登録されました。'
    else
      render :new
    end
  end

  def index
    #@rooms = Room.all
    @rooms = current_user.rooms
  end

  def show
    @reservation = Reservation.new
  end

  private

  def set_room
    @room = Room.find_by(id: params[:id])
    unless @room
      redirect_to rooms_path, alert: '施設が見つかりませんでした。'
    end
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end

  # def search
    # puts "params: #{params.inspect}"
    # render plain: "area: #{params[:area]}, keyword: #{params[:keyword]}"
    # puts params.inspect

  # end
   
 
  
  def search
  
    puts "===== ここまで来たよ ====="

   # 正規化
   @area = params[:area].to_s
   puts "DEBUG1: raw area=#{@area.inspect} length=#{@area.length}"

   @area = @area.strip.gsub(/[\u3000\s]+/, '')
   puts "DEBUG2: normalized area=#{@area.inspect} length=#{@area.length}"

   @keyword = params[:keyword].to_s.strip.gsub(/[\u3000\s]+/, '')
   puts "DEBUG3: normalized keyword=#{@keyword.inspect} length=#{@keyword.length}"

   @rooms = Room.all

   # クエリ条件追加
   conditions = []
   values = []

   if @area.present?
     puts "===== DEBUG: 条件（エリア検索）を追加します ====="
     conditions << "(address LIKE ? OR area LIKE ?)"
     values += ["%#{@area}%", "%#{@area}%"]
   end

   if @keyword.present?
     puts "===== DEBUG: 条件（キーワード検索）を追加します ====="
     conditions << "(name LIKE ? OR description LIKE ?)"
     values += ["%#{@keyword}%", "%#{@keyword}%"]
   end

   # 条件があれば追加
  puts "===== conditions.any? == #{conditions.any?} ====="

   if conditions.any?
     query = conditions.join(" AND ")
     @rooms = @rooms.where(query, *values)

     # この位置でSQL確認
     puts "===== 最終SQL文 (inside where) ====="
     puts @rooms.to_sql
   end

   # 最終SQL文確認（全体でも確認）
   puts "===== 最終SQL文 (outside where) ====="
   puts @rooms.to_sql

   # 件数確認
   puts "===== 件数 ====="
   puts @rooms.count

   # 結果の中身確認
   puts "===== DEBUG: 結果の中身 ====="
  @rooms.each do |room|
    puts "#{room.name} / #{room.area} / #{room.address}"
  end

   @count = @rooms.count
   render :search

  
  end


end









ｓ