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
        Wiki.where(:user_id => current_user.id, :private => true).each do |wiki|
          wiki.private = false
          wiki.save
        end 
        flash[:notice] = "You have been downgraded to the Free Plan and your private wikis are no longer private!"
        redirect_to wikis_path # or wherever
      end
    end 
  end
end
