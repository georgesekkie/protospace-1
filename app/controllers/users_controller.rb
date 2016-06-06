class UsersController < ApplicationController
  before_action :set_user, only: %i(show update edit)

  def show
    @prototypes = @user.prototypes
  end

  def edit
  end

  def update
    @user.update(user_params)
    flash[:success] = 'Your data was successfully updated'
    redirect_to action: :show
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile, :works, :email, :password, :group)
  end
end
