class TaskSerializer
  def initialize(task)
    @task = task
  end

  def as_json(*)
    {
      id: @task.id,
      title: @task.title,
      status: @task.status,
      created_at: @task.created_at,
      updated_at: @task.updated_at
    }
  end
end
