# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create!(username: "Example User",
            email: "example@railstutorial.org",
            password: "111111",
            password_confirmation: "111111",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

            
            
            
49.times do |n|
    username = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "111111"
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

userFirst = User.first
followings = User.all[2..20]
followers = User.all[3..20]
followings.each { |followed| userFirst.follow(followed) }
followers.each { |follower| follower.follow(userFirst) }

posts = Post.all[170..180]
users_thumb = User.all[2..20]
users_thumb.each { |user|
    posts.each { |post|
        Thumb.create(user_id: user.id, post_id: post.id, is_thumb: true)
    }
}

users_comment = User.all[1..10]
users_comment.each { |user|
    posts.each { |post|
        content = Faker::Lorem.sentence(5)
        user.comments.create!(content: content, post_id: post.id)
    }
}

users_reply = User.all[10..20]
comments = Comment.all[1..10]
users_reply.each { |user|
    comments.each { |comment|
        content = Faker::Lorem.sentence(5)
        user.replies.create!(content: content, comment_id: comment.id,
                replies_id: comment.user_id)
    }
}


replies = Replies.all[1..20]
users_comment.each { |user|
    replies.each { |reply|
        content = Faker::Lorem.sentence(5)
        user.replies.create!(content: content, comment_id: comment.id, 
            replies_id: reply.user_id)
    }
}




