class Product < ApplicationRecord
    belongs_to :category
    has_one_attached :image
    
    validates :name, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0}
    validates :published, inclusion: { in: [true, false] }

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end

end
