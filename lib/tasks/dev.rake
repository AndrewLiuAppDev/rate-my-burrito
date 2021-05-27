desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do
  require 'faker'

  User.delete_all
  Burrito.delete_all
  Rating.delete_all
  Restaurant.delete_all

  people = Array.new(10) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
    }
  end

  people << { first_name: "Peter", last_name: "Parker" }
  usertype = ["Restaurant Owner", "Customer"]

  people.each do |person|
    username = person.fetch(:first_name).downcase

    user = User.create(
      email: "#{username}@example.com",
      password: "password",
      name: "#{person[:first_name]} #{person[:last_name]}",
      burritos_count: 0,
      ratings_count: 0,
      restaurants_count: 0,
      user_type: usertype.sample
    )
    p user.errors.full_messages
  end

  users = User.all

  users.each do |user|
    rand(3).times do
      restaurant = user.restaurants.create(
        name: Faker::Restaurant.name,
        burritos_count: 0
      )
    end
  end

  tortillatype = ["Corn", "Flour"]
  burritoimages = ["https://tinyurl.com/nesuzs4w", "https://tinyurl.com/26hw2f44", "https://tinyurl.com/7jt538v4", "https://tinyurl.com/534tmycd", "https://tinyurl.com/2v76kz6x", "https://tinyurl.com/rp6yfdfm"]
  restaurants = Restaurant.all

  users.each do |user|
    rand(10).times do
      burrito = user.burritos.create(
        name: Faker::Food.dish + " Burrito",
        price: rand(3.0..20.0).round(2),
        ratings_count: 0,
        tortilla: tortillatype.sample,
        restaurant_id: restaurants.sample.id,
        image: burritoimages.sample
      )
    end
  end

  burritos = Burrito.all
  
  users.each do |user|
    burritos.each do |burrito|
      if rand < 0.5
        user_rating = user.ratings.create(
          rating_value: rand(1..6),
          burrito: burrito
        )
      end
    end
  end

  p "There are now #{User.count} users."
  p "There are now #{Restaurant.count} restaurants."
  p "There are now #{Burrito.count} burritos."
  p "There are now #{Rating.count} ratings."
end
