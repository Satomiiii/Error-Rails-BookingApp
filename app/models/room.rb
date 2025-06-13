class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  has_many :reservations, dependent: :destroy

  # saveの前に呼ぶ
  before_save :normalize_text_fields

  private

  def normalize_text_fields
    # 全角スペース・半角スペース・改行・タブを除去
    self.area = area.to_s.gsub(/[\u3000\s\r\n\t]/, '') if area.present?
    self.address = address.to_s.gsub(/[\u3000\s\r\n\t]/, '') if address.present?
    self.name = name.to_s.gsub(/[\u3000\s\r\n\t]/, '') if name.present?
    self.description = description.to_s.gsub(/[\u3000\s\r\n\t]/, '') if description.present?
  end
end
