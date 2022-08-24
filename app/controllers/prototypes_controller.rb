class PrototypesController < ApplicationController
  before_action :authenticate_user!, only:[:new ,:edit ,:destroy]
  #before_action :move_to_index, only: [:edit]
  
  def index
    @prototypes = Prototype.all
    ## @user= User.find(params[:user_id])
    # @prototypes = @user.prototypes.includes(:user)
  end
  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
    #@user = User.find_by(id: @prototype.user_id)
  end
  def  new
    @prototype = Prototype.new
  end
  def create
    ##Prototype.save(prototype_params)
    #@user= User.find(params[:user_id])
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      #@prototypes = @user.prototype.includes(:user)
      render :new
    end
  end

    def edit
      @prototype = Prototype.find(params[:id])
      unless user_signed_in? && current_user.id == @prototype.user_id
        redirect_to action: :index
      end
    end

    def update
      @prototype = Prototype.find(params[:id])
      if @prototype.update(prototype_params)
        redirect_to prototype_path
      else
        render :edit
      end
    end
   
      def destroy
        @prototype = Prototype.find(params[:id])
       if  @prototype.destroy
        redirect_to root_path
       else
        render :edit
      end
    end
  

  private
  def prototype_params
    params.require(:prototype).permit( :image,:title,:catch_copy,:concept).merge(user_id: current_user.id)
  end
  
  
end
