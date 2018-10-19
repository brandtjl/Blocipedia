class WikisController < ApplicationController
  def index
    # if current_user.admin? || current_user.premium?
    #   @wikis = Wiki.all
    # else 
    #   @wikis = Wiki.where(private: false)
    # end
    @wikis = policy_scope(Wiki)
    authorize @wikis
    
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
    @collaborator = Collaborator.new
  end

  def create
    # @wiki = Wiki.new
    # @wiki.title = params[:wiki][:title]
    # @wiki.body = params[:wiki][:body]
    # @wiki.private = params[:wiki][:private]
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end 

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @collaborator = Collaborator.find_by(wiki_id: @wiki.id)
  end

  def update
    @wiki = Wiki.find(params[:id])
    # @wiki.title = params[:wiki][:title]
    # @wiki.body = params[:wiki][:body]
    @wiki.assign_attributes(wiki_params)
    
    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end 

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end 

  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
