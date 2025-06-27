# app/views/tasks/index.json.jbuilder
json.status "success"
json.tasks_count @tasks.count
json.tasks @tasks do |task|
  json.id task.id
  json.title task.title
end
