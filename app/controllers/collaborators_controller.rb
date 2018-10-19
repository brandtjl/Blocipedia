class CollaboratorsController < ApplicationController
  def index 
    @collaborators. Collaborator.all
  end 

  def new
    @collaborator = Collaborator.new
  end

  def create
    user = User.find( params[:collaborator][:user_id] )
    wiki = Wiki.find( params[:collaborator][:wiki_id] )

    collaborator = Collaborator.new
    collaborator.user = user 
    collaborator.wiki = wiki
    collaborator.save
  end

  def destroy
  end
end
