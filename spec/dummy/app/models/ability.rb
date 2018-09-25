class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return unless user.persisted?

    can %i[read create update], ShoppingCart::Order, user_id: user.id
  end
end
