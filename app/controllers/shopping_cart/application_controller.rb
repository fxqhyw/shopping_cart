module ShoppingCart
  class ApplicationController < ActionController::Base
    include ShoppingCart::CurrentSession
    helper_method :current_order


    # #ActionController::Base
    # protect_from_forgery with: :exception
    # helper_method :current_order


  end
end
