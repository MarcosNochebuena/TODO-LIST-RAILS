class UserSerializer
  include JSONAPI::Serializer
  set_type :user
  attributes :id, :email, :created_at
end
