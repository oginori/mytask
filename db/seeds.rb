User.create!(name: "admin", email: "admin@example.com", password: "admin_password", admin: true )

10.times do |i|
  User.create!(name: "test#{i + 1}", email: "test#{i + 1}@example.com",password: "password#{i + 1}", admin: false )
  Task.create!(name: "sample#{i + 1}", description: "sample#{i + 1}_description", user_id: "#{i + 1}" )
  Label.create!(name: "sample#{i + 1}")
end

3.times do |i|
  Labelling.create!(task_id: "#{i + 1}", label_id: 1)
end

3.times do |i|
  Labelling.create(task_id: 5, label_id: "#{i + 2}")
end
