Rails.application.routes.draw do

  root "user_authentication#recommendations"

  get ":user_id/recommendations" => "user_authentication#recommendations", as: :recommendations

  # Routes for the Rating resource:

  # CREATE
  post "/insert_rating" => "ratings#create", as: :new_rating
          
  # READ
  get("/ratings", { :controller => "ratings", :action => "index" })
  
  get("/ratings/:path_id", { :controller => "ratings", :action => "show" })
  
  # UPDATE
  
  post("/modify_rating/:path_id", { :controller => "ratings", :action => "update" })
  
  # DELETE
  get("/delete_rating/:path_id", { :controller => "ratings", :action => "destroy" })

  #------------------------------

  # Routes for the Restaurant resource:

  # CREATE
  post("/insert_restaurant", { :controller => "restaurants", :action => "create" })
          
  # READ
  get("/restaurants", { :controller => "restaurants", :action => "index" })
  
  get "/restaurants/:path_id" => "restaurants#show", as: :restaurant
  
  # UPDATE
  
  post("/modify_restaurant/:path_id", { :controller => "restaurants", :action => "update" })
  
  # DELETE
  get("/delete_restaurant/:path_id", { :controller => "restaurants", :action => "destroy" })

  #------------------------------

  # Routes for the Burrito resource:

  # CREATE
  post("/insert_burrito", { :controller => "burritos", :action => "create" })
          
  # READ
  get("/burritos", { :controller => "burritos", :action => "index" })
  
  get("/burritos/:path_id", { :controller => "burritos", :action => "show" })
  
  # UPDATE
  
  post("/modify_burrito/:path_id", { :controller => "burritos", :action => "update" })
  
  # DELETE
  get("/delete_burrito/:path_id", { :controller => "burritos", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get "/user_sign_up" => "user_authentication#sign_up_form"     
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
