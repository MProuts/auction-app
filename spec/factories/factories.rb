FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email } 
    password "1234"
    password_confirmation "1234"
  end

  factory :auction do
    title       { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    end_time    Time.new(2016, 8, 8)
  end

end
