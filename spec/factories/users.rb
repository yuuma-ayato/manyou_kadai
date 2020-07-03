FactoryBot.define do
  factory :user1 ,class: User do
    id { 10000 }
    name { 'sample' }
    email { 'sample1@example.com' }
    password { '00000000' }
    #admin { false }
  end
end
