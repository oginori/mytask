FactoryBot.define do
  factory :task do
    name { 'title1' }
    description { 'content1' }
    status { '着手中'}
    priority {'low'}
    created_at { Time.current + 1.days }
    expired_at { Time.current + 1.days }
    user
  end
  factory :second_task, class: Task do
    name { 'title2' }
    description { 'content2' }
    status { '着手中'}
    priority {'low'}
    created_at { Time.current + 2.days }
    expired_at { Time.current + 2.days }
    user
  end
  factory :third_task, class: Task do
    name { 'title3' }
    description { 'content3' }
    status { '着手中'}
    priority {'medium'}
    created_at { Time.current + 3.days }
    expired_at { Time.current + 3.days }
    user
  end
  factory :fourth_task, class: Task do
    name { 'title4' }
    status { '着手中'}
    description { 'content4' }
    priority {'medium'}
    created_at { Time.current + 4.days }
    expired_at { Time.current + 4.days }
    user
  end
  factory :fifth_task, class: Task do
    name { 'title5' }
    status { '着手中'}
    description { 'content5' }
    priority {'high'}
    created_at { Time.current + 5.days }
    expired_at { Time.current + 5.days }
    user
  end
end
