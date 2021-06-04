class RestaurantsController < ApplicationController
  def index
    matching_restaurants = Restaurant.all

    @list_of_restaurants = matching_restaurants.order({ :created_at => :desc })

    render({ :template => "restaurants/index.html.erb" })
  end

  def show
    id = params.fetch("path_id")

    matching_restaurants = Restaurant.where(id: id)

    @restaurant = matching_restaurants.at(0)

    render template: "restaurants/show.html.erb"
  end

  def create
    restaurant = Restaurant.new
    restaurant.name = params.fetch("name")
    restaurant.owner_id = params.fetch("owner_id")
    restaurant.image = params.fetch("image")
    restaurant.burritos_count = params.fetch("burritos_count")

    if restaurant.valid?
      restaurant.save
      redirect_to("/restaurants", { :notice => "Restaurant created successfully." })
    else
      redirect_to("/restaurants", { :notice => "Restaurant failed to create successfully." })
    end
  end

  def update
    id = params.fetch("path_id")
    restaurant = Restaurant.where({ :id => id }).at(0)

    unless RestaurantPolicy.new(@current_user, restaurant).update?
      raise Pundit::NotAuthorizedError, "not allowed"
    end

    restaurant.name = params.fetch("name")
    restaurant.owner_id = params.fetch("owner_id")
    restaurant.image = params.fetch("image")
    restaurant.burritos_count = params.fetch("burritos_count")

    if restaurant.valid?
      restaurant.save
      redirect_to("/restaurants/#{restaurant.id}", { :notice => "Restaurant updated successfully."} )
    else
      redirect_to("/restaurants/#{restaurant.id}", { :alert => "Restaurant failed to update successfully." })
    end
  end

  def destroy
    id = params.fetch("path_id")
    restaurant = Restaurant.where({ :id => id }).at(0)
    
    unless RestaurantPolicy.new(@current_user, restaurant).destroy?
      raise Pundit::NotAuthorizedError, "not allowed"
    end


    restaurant.destroy

    redirect_to("/restaurants", { :notice => "Restaurant deleted successfully."} )
  end
end
