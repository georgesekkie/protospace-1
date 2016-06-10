class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: %i(create new)
  before_action :set_prototype, only: %i(show edit update)

  def index
    @prototypes = Prototype.includes(:user, :main_image).page(params[:page])
  end

  def new
    @prototype = Prototype.new
    @prototype.images.build
  end

  def show
    @sub_images = @prototype.images.sub
    @user = @prototype.user
  end

  def create
    prototype = current_user.prototypes.new(prototype_params)
    if prototype.save
      flash[:success] = 'Your prototype was successfully posted'
      redirect_to action: :index
    else
      flash[:warning] = 'Failed'
      redirect_to action: :new
    end
  end

  def edit
    @main = @prototype.main_image
    @sub = @prototype.images.sub
    @sub_count = @sub.count
  end

  def update
    @prototype.update(prototype_params)
    flash[:success] = 'Your prototype was successfully updated'
    redirect_to action: :show
  end

  private

  def prototype_params
    params.require(:prototype).permit(:name, :concept, :catch_copy, images_attributes: [:status, :image, :id])
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
