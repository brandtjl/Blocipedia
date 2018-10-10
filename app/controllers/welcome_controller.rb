class WelcomeController < ApplicationController
  def index
  end

  def about
    if current_user.account == 'free'
      flash[:notice] = "You are already on the Free Plan!"
      redirect_to root_path
    else
      @user = User.find(current_user.id)
      @user.account = 'free'
      if @user.save
        flash[:notice] = "You have been downgraded to the Free Plan!"
        redirect_to wikis_path # or wherever
      end
    end 
  end
end
