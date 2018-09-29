module ShoppingCart
  class AddressesController < ApplicationController
    include Rectify::ControllerHelpers
    before_action :authenticate_user!

    def update
      SettingsAddresser.call(address_params) do
        on(:ok) { redirect_to address_path, notice: I18n.t('notice.updated') }
        on(:invalid) do |address|
          expose(address: address)
          render :edit
        end
      end
    end

    private

    def address_params
      params.require(:address).permit(:first_name, :last_name, :address, :city, :zip,
                                      :country, :phone, :type, :user_id)
    end
  end
end
