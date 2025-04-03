# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

100.times do
  project_counter = Array.new(5) { ('a'..'z').to_a.sample }.join
  project = Project.create(name: "Project #{project_counter}" )

  active_tasks = 15.times.map { |task_counter| { name: "Active Task #{project_counter} - #{task_counter}", status: 0, expires_at: 6.months.from_now } }
  expired_tasks = (15..30).map { |task_counter| { name: "Expired Task #{project_counter} - #{task_counter}", status: 1, expires_at: task_counter.days.ago } }

  project.tasks.insert_all(active_tasks + expired_tasks)

  project.tasks.active.first(5).each_with_index do |task, index|
    subtasks = [
      { name: "Active SubTask #{project_counter} - #{task.id} - #{index}", status: 0, parent_task_id: task.id, expires_at: 6.months.from_now },
      { name: "Active SubTask #{project_counter} - #{task.id} - #{index + 1}", status: 0, parent_task_id: task.id, expires_at: 6.months.from_now },
      { name: "Expires today SubTask #{project_counter} - #{task.id} - #{index + 2}", status: 0, parent_task_id: task.id, expires_at: Time.current },
      { name: "Expired SubTask #{project_counter} - #{task.id} - #{index}", status: 1, parent_task_id: task.id, expires_at: 1.day.ago }
    ]
    project.tasks.insert_all(subtasks)
  end

  project.tasks.expired.first(5).each_with_index do |task, index|
    project.tasks.create(name: "Expired SubTask #{project_counter} - #{task.id} - #{index}", status: 1, parent_task: task, expires_at: 1.day.ago)
  end
end
