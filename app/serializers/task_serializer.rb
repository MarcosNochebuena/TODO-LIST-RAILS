class TaskSerializer
  include JSONAPI::Serializer
  set_type :task
  attributes :title, :description, :status

  attribute :user do |task|
    { id: task.user.id, email: task.user.email, jti: task.user.jti }
  end
end
