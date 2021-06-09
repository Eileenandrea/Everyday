class Comment < ApplicationRecord
    belongs_to :task
    validates :body, presence: true, length: {minimum:1, maximum: 1800}
end
