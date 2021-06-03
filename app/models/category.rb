class Category < ApplicationRecord
    validates :name, presence: true,
                length: {minimum: 3, maximum: 180}
    validates :description, length: {maximum: 1800}
    belongs_to :user
    has_many :tasks, dependent: :destroy

    def percent_complete
        return 0 if total_items == 0
        (100 * completed_items.to_f / total_items).round(1)
      end
    def completed_items
        @completed_items ||= tasks.completed.count
    end
    def total_items
        @total_items ||= tasks.count
    end
    def status
        case percent_complete.to_i
          when 0
            'Not started'
          when 100
            'Complete'
          else
            'In progress'
        end
    end
    def badge_color
        case percent_complete.to_i
          when 0
            'dark'
          when 100
            'info'
          else
            'primary'
        end
    end
end
