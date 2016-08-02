module UserHelper

  def redirect_if_not_logged_in
    if !logged_in?
      redirect_to login_path
      #error=Sorry. You have to be logged in to do that!"
    end
  end

  def logged_in?
    !!session[:user_id]
  end

end
