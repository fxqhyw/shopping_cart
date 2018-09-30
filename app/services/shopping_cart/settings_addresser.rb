module ShoppingCart
  class SettingsAddresser < Rectify::Command
    def initialize(params)
      @params = params
    end

    def call
      address = find_address || new_address
      return broadcast(:invalid, address) unless address.update(@params)

      broadcast(:ok)
    end

    private

    def find_address
      Address.find_by(user_id: @params[:user_id], type: @params[:type])
    end

    def new_address
      Address.new(user_id: @params[:user_id], type: @params[:type])
    end
  end
end
