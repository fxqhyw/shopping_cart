class SessionsController < Devise::SessionsController
  def create
    super
    return unless params[:user][:from_checkout]

    OrderTransfer.call(@user) do
      on(:ok) { cookies.delete :order_id }
    end
  end

  protected

  def after_sign_in_path_for(resource)
    return shopping_cart.checkouts_path if params[:user][:from_checkout]

    main_app.root_path
  end
end
