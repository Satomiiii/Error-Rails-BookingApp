class RoomsController < ApplicationController
  require 'nkf'  # 文字コード正規化用
  
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
    puts "DEBUG: @rooms => #{@rooms.inspect}"
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

   @rooms = Room.none        # ← まず空Relationで初期化（nil回避）

  area    = params[:area].to_s.strip
  keyword = params[:keyword].to_s.strip

  query  = []
  values = []

  if area.present?
    query  << "(address LIKE ? OR area LIKE ?)"
    values << "%#{area}%" << "%#{area}%"
  end

  if keyword.present?
    query  << "(name LIKE ? OR description LIKE ?)"
    values << "%#{keyword}%" << "%#{keyword}%"
  end

  @rooms = Room.where(query.join(' AND '), *values) unless query.empty?
  @count = @rooms.size

  Rails.logger.debug "PARAMS area=#{area} keyword=#{keyword}"
  Rails.logger.debug "[DEBUG SQL] #{Room.where(query.join(' AND '), *values).to_sql}" unless query.empty?
  Rails.logger.debug "DEBUG: @rooms => #{@rooms.inspect}"

  puts "PARAMS: #{params.inspect}"
  puts "SQL: #{Room.where(query.join(' AND '), *values).to_sql}" unless query.empty?
  puts "RESULT: #{@rooms.inspect}"


 if @rooms.blank?
  Rails.logger.debug "DEBUG: @rooms is EMPTY or NIL"
 else
  Rails.logger.debug "DEBUG: @rooms has #{@rooms.size} records"
  Rails.logger.debug "DEBUG: @rooms => #{@rooms.inspect}"
 end




  render :search
 
 end



end





