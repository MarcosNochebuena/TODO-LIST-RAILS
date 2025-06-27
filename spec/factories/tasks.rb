FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyString" }
    status { 1 }
    user { nil }
  end
end
