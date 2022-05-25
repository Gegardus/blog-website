# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(name: 'Tom',
                         photo: 'https://img1.freepng.ru/20180319/row/kisspng-computer-icons-google-account-user-profile-iconfin-png-icons-download-profile-5ab0301d8907a6.3404305715214960935613.jpg', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly',
                          photo: 'https://img1.freepng.ru/20180319/row/kisspng-computer-icons-google-account-user-profile-iconfin-png-icons-download-profile-5ab0301d8907a6.3404305715214960935613.jpg', bio: 'Teacher from Poland.')
third_user = User.create(name: 'Vahan',
                         photo: 'https://img1.freepng.ru/20180319/row/kisspng-computer-icons-google-account-user-profile-iconfin-png-icons-download-profile-5ab0301d8907a6.3404305715214960935613.jpg', bio: 'Teacher from Georgia.')
forth_user = User.create(name: 'Ani',
                         photo: 'https://img1.freepng.ru/20180319/row/kisspng-computer-icons-google-account-user-profile-iconfin-png-icons-download-profile-5ab0301d8907a6.3404305715214960935613.jpg', bio: 'Teacher from Armenia.')

first_post = Post.create(author: first_user, title: 'Hello', text: 'This is first post')
second_post = Post.create(author: first_user, title: 'Hello', text: 'This is second post')
third_post = Post.create(author: second_user, title: 'Hello', text: 'This is third post')
fourth_post = Post.create(author: second_user, title: 'Hello', text: 'This is fourth post')
first_post = Post.create(author: third_user, title: 'Hello', text: 'This is fifth post')
second_post = Post.create(author: third_user, title: 'Hello', text: 'This is sixth post')
third_post = Post.create(author: forth_user, title: 'Hello', text: 'This is seventh post')
fourth_post = Post.create(author: forth_user, title: 'Hello', text: 'This is eighth post')

Comment.create(post: first_post, author: second_user, text: 'Hi Tom!')
Comment.create(post: first_post, author: first_user, text: 'Hi Lilly!')
Comment.create(post: second_post, author: second_user, text: 'Hi , this is my first comment')
Comment.create(post: second_post, author: second_user, text: 'Hi , this is my second comment')

Like.create(post: first_post, author: second_user)
Like.create(post: second_post, author: first_user)

puts 'Seed data loaded successfully'
