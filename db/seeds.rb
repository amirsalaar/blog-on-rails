# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = 'supersecret'
Comment.delete_all
Post.delete_all
User.delete_all

User.create(
    name: 'Amirsalar',
    email: 'amirsalaar@gmail.com',
    password: PASSWORD,
    is_admin: true
)

10.times do
    created_at = Faker::Date.backward(365) 
    User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        created_at: created_at,
        updated_at: created_at,
        password: PASSWORD
    )
end

users = User.all

100.times do 
    created_at = Faker::Date.backward(365) 
    p = Post.create(
        title: Faker::Food.dish,
        body: Faker::Hacker.say_something_smart,
        created_at: created_at,
        updated_at: created_at,
        user: users.shuffle.sample
    )
    if p.valid?
        p.comments = rand(1..7).times.map do
            Comment.new(
                name: Faker::Name.first_name,
                body: Faker::Quote.famous_last_words,
                user: users.shuffle.sample,
                created_at: created_at
            )
        end
    end
end

posts = Post.all
comments = Comment.all

puts Cowsay.say("Generated #{posts.count} posts", :ghostbusters)
puts Cowsay.say("Generated #{comments.count} comments", :sheep)

