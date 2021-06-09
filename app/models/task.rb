class Task < ApplicationRecord
    belongs_to :category
    has_many :comments, dependent: :destroy
    validates :name, presence: true,
    length: {minimum: 3, maximum: 180}
    validates :description, length: {maximum: 1800}
    scope :completed, -> do
        where(completed:true)
      end
  
    def priority_status
      case priority
        when 3
          'Low'
        when 2
          'Medium'
        when 1
          'High'
        end
    end
    def priority_status_color
      case priority
        when 3
          'success'
        when 2
          'warning'
        when 1
          'danger'
        end
    end
    def status
      if completed
        'completed'
      elsif !completed && due_date.today?
        'Due Today'
      elsif !completed && due_date.to_date.past?
        'Overdue'
      elsif !completed && due_date.to_date.future?
        'Pending'
      end
    end
    def status_color
      if completed
        'success'
      elsif !completed && due_date.today?
        'warning'
      elsif !completed && due_date.to_date.past?
        'danger'
      elsif !completed && due_date.to_date.future?
        'secondary'
      end
    end
end