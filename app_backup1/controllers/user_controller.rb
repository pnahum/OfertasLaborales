class UserController < ApplicationController
  before_action :set_user, only: %i[ show ]


  # GET /offers/1 or /offers/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
#      @user = User.find(params[:id])
	@user = current_user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:id, :email, :name, :description, :image)
    end
end
