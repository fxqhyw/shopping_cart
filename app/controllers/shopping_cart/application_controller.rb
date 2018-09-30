module ShoppingCart
  class ApplicationController < ::ApplicationController
    include ShoppingCart::CurrentSession
    helper_method :current_order
    layout 'application'
  end
end
