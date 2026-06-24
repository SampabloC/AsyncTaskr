class Task < ApplicationRecord
  belongs_to :user

  # STATUSES = %w[pending in_progress completed failed]

  enum :status, {
    pending: "pending",
    in_progress: "in_progress",
    completed: "completed",
    failed: "failed"
  }, validate: true

  validates :title, presence: true
end
