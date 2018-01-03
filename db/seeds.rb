# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

one = User.create(email: 'one@one.com')
two = User.create(email: 'two@two.com')

one_p1 = Post.create(user: one, title: 'Apple picking', body: "It's fun for everyone but only in season.")
one_p2 = Post.create(user: one, title: 'Eating a healthy breakfast', body: "Skip breakfast, you really don't need it.")
one_p3 = Post.create(user: one, title: 'Find your missing keys', body: "I'm just as lost as you are. Perhaps they are right where you left them.")

two_p1 = Post.create(user: two, title: 'Cooking chili', body: "It's a great winter-time dish. Takes about 1.5 hours to make.")
two_p2 = Post.create(user: two, title: 'Being a good human', body: "It's harder and easier than it seems.")

Comment.create(user: one, post: two_p1, body: "Yum. I need to make that this weekend.")
Comment.create(user: one, post: two_p2, body: "Even if you could, how would you know?")

Comment.create(user: two, post: one_p1, body: "I've never been apple picking.")
Comment.create(user: two, post: one_p2, body: "I always eat breakfast.")
Comment.create(user: two, post: one_p3, body: "I always put my keys in the same place so I don't lose them.")
