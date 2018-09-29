module ShoppingCart
  class ApplicationController < ActionController::Base
    include ShoppingCart::CurrentSession
    helper_method :current_order
  end
end
