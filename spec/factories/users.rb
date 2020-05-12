FactoryBot.define do
  factory :user do
    id {1}
    name {"test_user"}
    email {"test@user.com"}
    password {"qwerty"}
    status {"active"}
  end
end
