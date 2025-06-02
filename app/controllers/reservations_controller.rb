class ReservationsController < ApplicationController
  before_action :set_room, only: [:new, :create]

  def new
    @reservation = Reservation.new(
      room: @room,
      check_in: params[:check_in],
      check_out: params[:check_out],
      guests: params[:guests]
    )
  end
  
  

  def confirm
    Rails.logger.info "Params received: #{params.inspect}"
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(reservation_params.merge(room: @room))
    
    # エラーハンドリング: パラメータが不完全な場合
    if @reservation.check_in.nil? || @reservation.check_out.nil? || @reservation.guests.nil?
      flash[:alert] = "予約情報が不完全です。"
      redirect_to room_path(@room)
    else
      @reservation.total_amount = calculate_total_amount(@reservation)
      render :confirm
    end
  end
  
    

  

  
  def create
    puts params.inspect # ここでリクエストパラメータをログに出力します
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.new(reservation_params.merge(room: @room))
    if @reservation.save
      redirect_to reservations_path, notice: '予約が確定しました。'
    else
      flash[:alert] = '予約に失敗しました。'
      render :new
    end
  end

  
  def index
    @reservations = current_user.reservations.includes(:room)
  end


 private
 
 def set_room
  @room = Room.find(params[:room_id])
 end
 

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guests, :room_id)
  end

  def calculate_total_amount(reservation)
    if reservation.room.nil?
      raise "Room is not associated with the reservation."
    end
  
    nights = (reservation.check_out.to_date - reservation.check_in.to_date).to_i
    room_price = reservation.room.price
    nights * room_price * reservation.guests
  end
  


 def show
  @room = Room.find(params[:id])
  @reservation = Reservation.new
 end

 
end


