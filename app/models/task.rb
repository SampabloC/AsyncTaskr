class Task < ApplicationRecord
  belongs_to :user

  STATUSES = %w[pending in_progress completed]

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= "pending"
  end
end
