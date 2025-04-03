class TaskExpirationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Task.active.where("expires_at <= ?", Time.current.end_of_day).update_all(status: 1)
  end
end
