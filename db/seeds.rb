User.create!(name: "test", email: "test@example.com",password: "password", admin: true )
Task.create!(name: "sample", description: "sample_description", user_id: 1)
