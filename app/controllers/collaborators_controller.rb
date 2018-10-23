class CollaboratorsController < ApplicationController
  def index 
    @collaborators. Collaborator.all
  end 

  def new
    @collaborator = Collaborator.new
  end

  def create
    puts params.inspect
    user = User.find_by_email(params[:collaborator][:email])
    wiki = Wiki.find(params[:collaborator][:wiki_id])
    puts user
    puts wiki
    collaborator = Collaborator.new
    collaborator.user = user 
    collaborator.wiki = wiki
    collaborator.email = params[:collaborator][:email] 
    collaborator.save
    redirect_to edit_wiki_path(wiki)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was deleted successfully."
      redirect_to edit_wiki_path(@collaborator.wiki_id)
    else
      flash.now[:alert] = "There was an error deleting the collaborator."
      redirect_to edit_wiki_path(wiki)
    end 
  end
end
