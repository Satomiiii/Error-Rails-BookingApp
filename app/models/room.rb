class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :name, :description, :price,  presence: true
  # validates :name, :description, :price, :addres, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  has_many :reservations, dependent: :destroy



  before_save :normalize_text_fields

   private

   def normalize_text_fields
    self.area = area.to_s.gsub(/[\u3000[:space:]]|\r|\n|\t/, '')
    self.address = address.to_s.gsub(/[\u3000[:space:]]|\r|\n|\t/, '')
   end



   
end

