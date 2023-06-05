# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
#  enum :role, [:normal_user, :author, :admin]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
#  before_actio :redirect_to_offers_if_not_admin
#  before_action :authenticate_user!
#  before_action only: [:new, :create, :edit, :update, :show, :destroy] do
#    authorize_request(["admin"])
#  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
   def create
#     super
	super do |user|
#		 if (!signed_in? or (signed_in? and current_user.role != 2))
			puts "########################"
			puts "#{current_user.role}"
			puts "########################"
			redirect_to new_offer_path
			user.save
		end
	end
   end

  # GET /resource/edit
   #def edit
   #  super
   #end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

#  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
