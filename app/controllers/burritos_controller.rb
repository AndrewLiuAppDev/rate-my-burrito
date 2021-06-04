class BurritosController < ApplicationController
  before_action :set_burrito, only: %i[ show edit update destroy ]

  def create
    @burrito = Burrito.new
    @burrito.name = params.fetch("name")
    @burrito.tortilla = params.fetch("tortilla")
    @burrito.image = params.fetch("image")
    @burrito.restaurant_id = params.fetch("restaurant_id")
    @burrito.owner_id = params.fetch("owner_id")
    @burrito.price = params.fetch("price")
    @burrito.ratings_count = params.fetch("ratings_count")

    respond_to do |format|
      if @burrito.save
        format.html { redirect_back fallback_location: root_path, notice: "Burrito was successfully created." }
        format.json { render :show, status: :created, location: @burrito }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @burrito.errors, status: :unprocessable_entity }
      end
    end
    
    # burrito = Burrito.new
    # burrito.name = params.fetch("name")
    # burrito.tortilla = params.fetch("tortilla")
    # burrito.image = params.fetch("image")
    # burrito.restaurant_id = params.fetch("restaurant_id")
    # burrito.owner_id = params.fetch("owner_id")
    # burrito.price = params.fetch("price")
    # burrito.ratings_count = params.fetch("ratings_count")

    # if burrito.valid?
    #   burrito.save
    #   redirect_to("/burritos", { :notice => "Burrito created successfully." })
    # else
    #   redirect_to("/burritos", { :notice => "Burrito failed to create successfully." })
    # end
  end

  def update

    unless BurritoPolicy.new(@current_user, @burrito).update?
      raise Pundit::NotAuthorizedError, "not allowed"
    end
    respond_to do |format|
      if @burrito.update(burrito_params)
        format.html { redirect_to root_url, notice: "Burrito was successfully updated." }
        format.json { render :show, status: :ok, location: @burrito }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @burrito.errors, status: :unprocessable_entity }
      end
    end

    # @burrito.name = params.fetch("name")
    # @burrito.tortilla = params.fetch("tortilla")
    # @burrito.image = params.fetch("image")
    # @burrito.restaurant_id = params.fetch("restaurant_id")
    # @burrito.owner_id = params.fetch("owner_id")
    # @burrito.price = params.fetch("price")
    # @burrito.ratings_count = params.fetch("ratings_count")

    # if @burrito.valid?
    #   burrito.save
    #   redirect_to("/burritos/#{burrito.id}", { :notice => "Burrito updated successfully."} )
    # else
    #   redirect_to("/burritos/#{burrito.id}", { :alert => "Burrito failed to update successfully." })
    # end
  end

  def destroy
    unless BurritoPolicy.new(@current_user, @burrito).destroy?
      raise Pundit::NotAuthorizedError, "not allowed"
    end
    @burrito.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_url, notice: "Burrito was successfully destroyed." }
      format.json { head :no_content }
    end
    # id = params.fetch("burrito_id")
    # burrito = Burrito.where( id: id ).at(0)
    
    # burrito.destroy
    
    # respond_to do |format|
    #   format.html { redirect_back fallback_location: root_url, notice: "Burrito deleted successfully." }

    #   format.js { render template: "burritos/destroy.js.erb"}
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_burrito
      @burrito = Burrito.find(params[:id])
    end
end
