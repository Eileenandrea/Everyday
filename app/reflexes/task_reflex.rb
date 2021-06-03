# frozen_string_literal: true

class TaskReflex < ApplicationReflex
  def toggle
    task = Task.find(element.dataset.id)
    task.update(completed:(task.completed ? false : true), completed_at:(task.completed_at ? nil : Time.now))
  end

end

