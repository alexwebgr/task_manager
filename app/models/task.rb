class Task < ApplicationRecord
  validates :name, presence: true
  validates :expires_at, presence: true

  enum :status, { active: 0, expired: 1 }

  belongs_to :project, optional: false
  belongs_to :parent_task, class_name: "Task", optional: true

  has_many :subtasks, class_name: "Task", foreign_key: "parent_task_id", dependent: :destroy
  has_many :active_subtasks, -> { active }, class_name: "Task", foreign_key: "parent_task_id", dependent: :destroy

  scope :top_level, -> { where(parent_task_id: nil) }

  before_validation :set_expiration_date

  def set_expiration_date
    self.expires_at = 6.months.from_now
  end
end
