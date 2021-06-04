class RatingsController < ApplicationController
  def index
    matching_ratings = Rating.all

    @list_of_ratings = matching_ratings.order({ :created_at => :desc })

    render({ :template => "ratings/index.html.erb" })
  end

  def show
    id = params.fetch("path_id")

    matching_ratings = Rating.where({ :id => id })

    @the_rating = matching_ratings.at(0)

    render({ :template => "ratings/show.html.erb" })
  end

  def create
    the_rating = Rating.new
    the_rating.rating_value = params.fetch("rating_value")
    the_rating.burrito_id = params.fetch("burrito_id")
    the_rating.rater_id = params.fetch("rater_id")

    if the_rating.valid?
      the_rating.save
      redirect_to("/ratings", { :notice => "Rating created successfully." })
    else
      redirect_to("/ratings", { :notice => "Rating failed to create successfully." })
    end
  end

  def update
    id = params.fetch("path_id")
    the_rating = Rating.where({ :id => id }).at(0)

    the_rating.rating_value = params.fetch("rating_value")
    the_rating.burrito_id = params.fetch("burrito_id")
    the_rating.rater_id = params.fetch("rater_id")

    if the_rating.valid?
      the_rating.save
      redirect_to("/ratings/#{the_rating.id}", { :notice => "Rating updated successfully."} )
    else
      redirect_to("/ratings/#{the_rating.id}", { :alert => "Rating failed to update successfully." })
    end
  end

  def destroy
    id = params.fetch("path_id")
    the_rating = Rating.where({ :id => id }).at(0)

    the_rating.destroy

    redirect_to("/ratings", { :notice => "Rating deleted successfully."} )
  end
end
