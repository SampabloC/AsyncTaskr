class Task < ApplicationRecord
  belongs_to :user

  enum :status, {
    pending: "pending",
    in_progress: "in_progress",
    completed: "completed",
    failed: "failed"
  }, validate: true

  validates :title, presence: true
end
