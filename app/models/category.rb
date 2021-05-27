class Category < ApplicationRecord
    validates :name, presence: true,
                length: {minimum: 3, maximum: 180}
    validates :description, length: {maximum: 1800}
    belongs_to :user
    has_many :tasks
end
