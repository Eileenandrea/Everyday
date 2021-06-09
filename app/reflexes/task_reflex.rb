# frozen_string_literal: true

class TaskReflex < ApplicationReflex
  def toggle
    task = Task.find(element.dataset.id)
    task.update(completed:(task.completed ? false : true), completed_at:(task.completed_at ? nil : Time.now))
  end
  def sort
    @sort_by = element.value
  end

  def toggleActive
    @active_tab = element.dataset.active
  end
  def toggleTaskDashboard
    @active_tab = element.dataset.active
    task = Task.find(element.dataset.id)
    task.update(completed:(task.completed ? false : true), completed_at:(task.completed_at ? nil : Time.now))
  end
  def sortDashboard
    @sort_by = element.value
    @active_tab = element.dataset.active
  end
end

