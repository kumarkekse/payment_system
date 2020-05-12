FactoryBot.define do
  factory :transaction do
    user
    amount {100}
    customer_email {'customer@test.com'}
    status {'approved'}
  end
end
