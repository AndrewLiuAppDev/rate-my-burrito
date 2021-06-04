class BurritosController < ApplicationController
  def index
    matching_burritos = Burrito.all

    @burritos = matching_burritos.order({ :created_at => :desc })

    render({ :template => "burritos/index.html.erb" })
  end

  def show
    id = params.fetch("burrito_id")

    matching_burritos = Burrito.where({ :id => id })

    @burrito = matching_burritos.at(0)

    render({ :template => "burritos/show.html.erb" })
  end

  def create
    burrito = Burrito.new
    burrito.name = params.fetch("name")
    burrito.tortilla = params.fetch("tortilla")
    burrito.image = params.fetch("image")
    burrito.restaurant_id = params.fetch("restaurant_id")
    burrito.owner_id = params.fetch("owner_id")
    burrito.price = params.fetch("price")
    burrito.ratings_count = params.fetch("ratings_count")

    if burrito.valid?
      burrito.save
      redirect_to("/burritos", { :notice => "Burrito created successfully." })
    else
      redirect_to("/burritos", { :notice => "Burrito failed to create successfully." })
    end
  end

  def update
    id = params.fetch("burrito_id")
    burrito = Burrito.where({ :id => id }).at(0)

    unless BurritoPolicy.new(@current_user, burrito).update?
      raise Pundit::NotAuthorizedError, "not allowed"
    end

    burrito.name = params.fetch("name")
    burrito.tortilla = params.fetch("tortilla")
    burrito.image = params.fetch("image")
    burrito.restaurant_id = params.fetch("restaurant_id")
    burrito.owner_id = params.fetch("owner_id")
    burrito.price = params.fetch("price")
    burrito.ratings_count = params.fetch("ratings_count")

    if burrito.valid?
      burrito.save
      redirect_to("/burritos/#{burrito.id}", { :notice => "Burrito updated successfully."} )
    else
      redirect_to("/burritos/#{burrito.id}", { :alert => "Burrito failed to update successfully." })
    end
  end

  def destroy
    id = params.fetch("burrito_id")
    burrito = Burrito.where( id: id ).at(0)
    unless BurritoPolicy.new(@current_user, burrito).destroy?
      raise Pundit::NotAuthorizedError, "not allowed"
    end
    burrito.destroy
    
    respond_to do |format|
      format.html { redirect_back fallback_location: root_url, notice: "Burrito deleted successfully." }

      format.js { render template: "burritos/destroy.js.erb"}
    end
  end
end
