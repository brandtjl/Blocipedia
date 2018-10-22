class CollaboratorsController < ApplicationController
  def index 
    @collaborators. Collaborator.all
  end 

  def new
    @collaborator = Collaborator.new
  end

  def create
    puts params.inspect
    user = User.find( params[:collaborator][:id] )
    wiki = Wiki.find( params[:collaborator][:wiki_id] )

    collaborator = Collaborator.new
    collaborator.user = user 
    collaborator.wiki = wiki
    collaborator.email = params[:collaborator][:email] 
    collaborator.save
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "\"#{@collaborator.user_id}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the collaborator."
      render :show
    end 
  end
end
