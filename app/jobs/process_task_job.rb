class ProcessTaskJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find(task_id)
    task.in_progress!

    sleep(5)
    raise StandardError, "Simulated error for task #{task_id}" if task.title.include?("fail")
    task.completed!
  rescue StandardError => e
    task.failed!

    Rails.logger.error("Error occurred while processing task #{task_id}: #{e.message}")
  end
end
