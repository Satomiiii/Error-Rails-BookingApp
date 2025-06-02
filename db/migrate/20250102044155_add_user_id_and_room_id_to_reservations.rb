class AddUserIdAndRoomIdToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :user, null: false, foreign_key: true unless column_exists?(:reservations, :user_id)
    add_reference :reservations, :room, null: false, foreign_key: true unless column_exists?(:reservations, :room_id)
  end
end
