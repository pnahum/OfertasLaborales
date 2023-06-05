class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :redirect_to_offers_if_not_admin_in_registrations, if: :devise_controller?

protected

        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :description])
                devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :description])
	end
	def after_sign_in_path_for(resource)
                offers_path
        end

        def authorize_request(kind = nil)
                unless kind.include?(current_user.role)
                        redirect_to offers_path, notice: "You are not authorized to perform this action"
                end
        end

	def redirect_to_offers_if_not_admin_in_registrations
		if (!signed_in? or (signed_in? and current_user.role != 2)) and (controller_name == "registrations")
#			puts "########################"
#			puts controller_name, "  ", action_name
#			puts "#{current_user.role}"
#			puts "########################"
                	redirect_to root_path
		end
	end
end
