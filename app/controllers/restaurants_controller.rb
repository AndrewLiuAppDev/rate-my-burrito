class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy ]
  def index
    @restaurants = Restaurant.all
  end

  def show
  end

  def create
    @restaurant = Restaurant.new
    @restaurant.name = params.fetch("name")
    @restaurant.owner_id = params.fetch("owner_id")
    @restaurant.image = params.fetch("image")
    @restaurant.burritos_count = params.fetch("burritos_count")

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_back fallback_location: root_path, notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end

    # if restaurant.valid?
    #   restaurant.save
    #   redirect_to("/restaurants", { :notice => "Restaurant created successfully." })
    # else
    #   redirect_to("/restaurants", { :notice => "Restaurant failed to create successfully." })
    # end
  end

  def update
    unless RestaurantPolicy.new(@current_user, @restaurant).update?
      raise Pundit::NotAuthorizedError, "not allowed"
    end
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to root_url, notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
    
    # id = params.fetch("restaurant_id")
    # restaurant = Restaurant.where({ :id => id }).at(0)

    

    # restaurant.name = params.fetch("name")
    # restaurant.owner_id = params.fetch("owner_id")
    # restaurant.image = params.fetch("image")
    # restaurant.burritos_count = params.fetch("burritos_count")

    # if restaurant.valid?
    #   restaurant.save
    #   redirect_to("/restaurants/#{restaurant.id}", { :notice => "Restaurant updated successfully."} )
    # else
    #   redirect_to("/restaurants/#{restaurant.id}", { :alert => "Restaurant failed to update successfully." })
    # end
  end

  def destroy
    unless RestaurantPolicy.new(@current_user, @restaurant).destroy?
      raise Pundit::NotAuthorizedError, "not allowed"
    end
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_url, notice: "Restaurant was successfully destroyed." }
      format.json { head :no_content }
    end

    # id = params.fetch("restaurant_id")
    # restaurant = Restaurant.where({ :id => id }).at(0)
    # restaurant.destroy

    # respond_to do |format|
    #   format.html { redirect_back fallback_location: root_url, notice: "Restaurant deleted successfully." }

    #   format.js { render template: "restaurant/destroy.js.erb"}
    # end
  end
   private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end
end
