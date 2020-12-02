FactoryBot.define do
  factory :user do
    name { "test" }
    email { "test@example.com" }
    password { "password" }
    admin { false }
  end

  factory :second_user, class: User do
    name { "sample" }
    email { "sample@example.com" }
    password { "sample_password" }
    admin { true }
  end

  factory :admin_user, class: User do
    name { "admin" }
    email { "admin@example.com" }
    password { "admin_password" }
    admin { true }
  end
end
