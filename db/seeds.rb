# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



User.create!(username: "Example User",
            email: "example@railstutorial.org",
            password: "foobar",
            password_confirmation: "foobar",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

            
            
            
49.times do |n|
    username = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(username: username,
                email: email,
                password: password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
30.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.posts.create!(content: content)}
end


users = User.all
user = users.first
followings = users[2..20]
followers = users[3..20]
followings.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

posts = Post.drop(10)
20.times do |n|
    user = User.find(n)
    posts.each { |post|
        Thumb.create(user_id: user.id, post_id: post.id, is_thumb: true)
    }
end




