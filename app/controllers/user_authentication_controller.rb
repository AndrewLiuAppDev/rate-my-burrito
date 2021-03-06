class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def sign_in_form
    render( template: "user_authentication/sign_in.html.erb" )
  end

  def create_cookie
    user = User.where({ :email => params.fetch("email") }).first
    
    the_supplied_password = params.fetch("password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render( template: "user_authentication/sign_up.html.erb")
  end

  def create
    @user = User.new
    @user.email = params.fetch("email")
    @user.password = params.fetch("password")
    @user.password_confirmation = params.fetch("password_confirmation")
    @user.user_type = params.fetch("user_type")
    @user.name = params.fetch("name")
    @user.avatar = ""
    @user.burritos_count = 0
    @user.ratings_count = 0
    @user.restaurants_count = 0

    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
   
      redirect_to("/", notice: "User account created successfully." )
    else
      redirect_to("/user_sign_up", alert: @user.errors.full_messages.to_sentence )
    end
  end
    
  def edit_profile_form
    render( template: "user_authentication/edit_profile.html.erb" )
  end

  def update
    @user = @current_user
    @user.email = params.fetch("email")
    @user.password = params.fetch("password")
    @user.password_confirmation = params.fetch("password_confirmation")
    @user.user_type = params.fetch("user_type")
    @user.name = params.fetch("name")
    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" , :alert => @user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled" })
  end

private

    def set_user
      if params[:user_id]
        @user = User.find_by!(user_id: params.fetch(:user_id))
      else
        @user = current_user
      end
    end

    def must_be_owner_to_view
      if current_user != @user
        redirect_back fallback_location: root_url, alert: "You're not authorized for that."
      end
    end
 
end
