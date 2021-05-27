class BurritosController < ApplicationController
  def index
    matching_burritos = Burrito.all

    @list_of_burritos = matching_burritos.order({ :created_at => :desc })

    render({ :template => "burritos/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_burritos = Burrito.where({ :id => the_id })

    @the_burrito = matching_burritos.at(0)

    render({ :template => "burritos/show.html.erb" })
  end

  def create
    the_burrito = Burrito.new
    the_burrito.name = params.fetch("query_name")
    the_burrito.tortilla = params.fetch("query_tortilla")
    the_burrito.image = params.fetch("query_image")
    the_burrito.restaurant_id = params.fetch("query_restaurant_id")
    the_burrito.owner_id = params.fetch("query_owner_id")
    the_burrito.price = params.fetch("query_price")
    the_burrito.ratings_count = params.fetch("query_ratings_count")

    if the_burrito.valid?
      the_burrito.save
      redirect_to("/burritos", { :notice => "Burrito created successfully." })
    else
      redirect_to("/burritos", { :notice => "Burrito failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_burrito = Burrito.where({ :id => the_id }).at(0)

    the_burrito.name = params.fetch("query_name")
    the_burrito.tortilla = params.fetch("query_tortilla")
    the_burrito.image = params.fetch("query_image")
    the_burrito.restaurant_id = params.fetch("query_restaurant_id")
    the_burrito.owner_id = params.fetch("query_owner_id")
    the_burrito.price = params.fetch("query_price")
    the_burrito.ratings_count = params.fetch("query_ratings_count")

    if the_burrito.valid?
      the_burrito.save
      redirect_to("/burritos/#{the_burrito.id}", { :notice => "Burrito updated successfully."} )
    else
      redirect_to("/burritos/#{the_burrito.id}", { :alert => "Burrito failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_burrito = Burrito.where({ :id => the_id }).at(0)

    the_burrito.destroy

    redirect_to("/burritos", { :notice => "Burrito deleted successfully."} )
  end
end
