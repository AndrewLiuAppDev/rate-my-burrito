class RestaurantPolicy
  attr_reader :user, :restaurant

  def initialize(user, restaurant)
    @user = user
    @restaurant = restaurant
  end

  def update?
    user == restaurant.owner
  end

  def destroy?
    user == restaurant.owner
  end
end