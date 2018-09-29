class RegistrationsController < Devise::RegistrationsController
  def create
    super
    return unless @user.save

    OrderTransfer.call(@user) do
      on(:ok) { cookies.delete :order_id }
    end
    flash[:notice] = I18n.t('notice.reg_message') + @user.email
  end

  protected

  def update_resource(resource, params)
    return super if params.include?(:current_password)

    resource.update_without_password(email_params)
  end

  def after_sign_up_path_for(resource)
    return shopping_cart.checkouts_path if params[:user][:from_checkout]

    main_app.root_path
  end

  private

  def email_params
    params.permit(:email)
  end
end
