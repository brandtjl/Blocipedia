class ChargesController < ApplicationController
  def index
  end

  def about
  end

  def new
    if current_user.account == 'premium'
      flash[:notice] = "You are already on the Premium Plan!"
      redirect_to root_path
    end 
    
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Membership - #{current_user}",
     amount: 1500
   }
   
  end

  def create
    if current_user.account == 'free'
      @user = User.find(current_user.id)
      @user.account = 'premium'
      
    # Creates a Stripe Customer object, for associating
    # with the charge
      customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
      )
    
      # Where the real magic happens
      charge = Stripe::Charge.create(
        customer: customer.id, # Note -- this is NOT the user_id in your app
        amount: 1500,
        description: "Premium Membership - #{current_user.email}",
        currency: 'usd'
      )
    
      if @user.save
        flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
        redirect_to wikis_path # or wherever
      end
    else
      flash[:notice] = "You are already on the Premium Plan!"
      redirect_to root_path
    end

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
