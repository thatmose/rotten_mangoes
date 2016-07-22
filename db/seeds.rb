30.times {
   User.create(
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name
      )
}

5.times {
   User.create(
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      admin: true
      )
}


60.times {
   Movie.create!(
      title: Faker::Book.title,
      director: Faker::Book.author,
      runtime_in_minutes: Faker::Number.between(60,180),
      description: Faker::Hacker.say_something_smart,
      release_date: Faker::Date.backward(600),
      remote_image_url: Faker::Avatar.image
      )
}

100.times {
   Review.create!(
      user_id: Faker::Number.between(1, 30),
      movie_id: Faker::Number.between(1, 60),
      text: Faker::Lorem.paragraph(2),
      rating_out_of_ten: Faker::Number.between(1, 10)
      )
}