class ApplicationController < ActionController::Base
    # before_action :authenticate_user!
    include Pundit
    protect_from_forgery

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    private

 def user_not_authorized(exception)
   policy_name = exception.policy.class.to_s.underscore

   flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: 'You are not authorized to edit this Wiki!'
   puts "Got this error"
   redirect_to(request.referrer || root_path)
 end
end
