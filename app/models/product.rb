class Product < ApplicationRecord
    validates :name, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0}
    validates :published, inclusion: { in: [true, false] }

end
