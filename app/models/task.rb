class Task < ApplicationRecord
    belongs_to :user
    belongs_to :category
    validates :name, presence: true,
    length: {minimum: 3, maximum: 180}
    validates :description, length: {maximum: 1800}
end