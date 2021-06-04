Rails.application.routes.draw do

  root "user_authentication#recommendations"

  get ":user_id/recommendations" => "user_authentication#recommendations", as: :recommendations

  # Routes for the Rating resource:

  # CREATE
  post "/insert_rating" => "ratings#create", as: :new_rating
          
  #------------------------------

  # Routes for the Restaurant resource:

  # CREATE
  post "/insert_restaurant" => "restaurants#create", as: :new_restaurant
          
  # READ
  get "/restaurants" => "restaurants#index", as: :restaurants
  
  get "/restaurants/:id" => "restaurants#show", as: :restaurant
  
  # UPDATE
  
  post "/modify_restaurant/:id" => "restaurants#update", as: :update_restaurant
  
  # DELETE
  get "/delete_restaurant/:id" => "restaurants#destroy", as: :delete_restaurant

  #------------------------------

  # Routes for the Burrito resource:

  # CREATE
  post "/insert_burrito" => "burritos#create", as: :new_burrito
          
  # READ
  
  get "/burritos/:id" => "burritos#show", as: :burrito
  
  # UPDATE
  
  post "/modify_burrito/:id" => "burritos#update", as: :update_burrito
  
  # DELETE
  get "/delete_burrito/:id" => "burritos#destroy", as: :delete_burrito

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get "/user_sign_up" => "user_authentication#sign_up_form"     
  # CREATE RECORD
  post "/insert_user" => "user_authentication#create"
      
  # EDIT PROFILE FORM        
  get "/edit_user_profile" => "user_authentication#edit_profile_form"       
  # UPDATE RECORD
  post "/modify_user" => "user_authentication#update"
  
  # DELETE RECORD
  get "/cancel_user_account" => "user_authentication#destroy"

  # ------------------------------

  # SIGN IN FORM
  get "/user_sign_in" => "user_authentication#sign_in_form"
  # AUTHENTICATE AND STORE COOKIE
  post "/user_verify_credentials" => "user_authentication#create_cookie"
  
  # SIGN OUT        
  get "/user_sign_out" => "user_authentication#destroy_cookies"
             
  #------------------------------

end
