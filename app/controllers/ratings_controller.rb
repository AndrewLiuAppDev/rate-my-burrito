class RatingsController < ApplicationController
  # def index
  #   matching_ratings = Rating.all

  #   @list_of_ratings = matching_ratings.order({ :created_at => :desc })

  #   render({ :template => "ratings/index.html.erb" })
  # end

  # def show
  #   id = params.fetch("id")

  #   matching_ratings = Rating.where({ :id => id })

  #   @the_rating = matching_ratings.at(0)

  #   render({ :template => "ratings/show.html.erb" })
  # end

  def create
    @rating = Rating.new
    @rating.rating_value = params.fetch("rating_value")
    @rating.burrito_id = params.fetch("burrito_id")
    @rating.rater_id = params.fetch("rater_id")

    respond_to do |format|
      if @rating.save
        format.html { redirect_back fallback_location: root_path, notice: "Rating was successfully created." }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   id = params.fetch("id")
  #   the_rating = Rating.where({ :id => id }).at(0)

  #   the_rating.rating_value = params.fetch("rating_value")
  #   the_rating.burrito_id = params.fetch("burrito_id")
  #   the_rating.rater_id = params.fetch("rater_id")

  #   if the_rating.valid?
  #     the_rating.save
  #     redirect_to("/ratings/#{the_rating.id}", { :notice => "Rating updated successfully."} )
  #   else
  #     redirect_to("/ratings/#{the_rating.id}", { :alert => "Rating failed to update successfully." })
  #   end
  # end

  # def destroy
  #   id = params.fetch("id")
  #   the_rating = Rating.where({ :id => id }).at(0)

  #   the_rating.destroy

  #   redirect_to("/ratings", { :notice => "Rating deleted successfully."} )
  # end
end
