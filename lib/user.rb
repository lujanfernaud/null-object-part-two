class User
  include ActiveModel::Model

  attr_accessor :created_at, :credit_card
  attr_writer   :subscription

  delegate :has_mentoring?, :price, :plan_name, to: :subscription

  def charge
    subscription.charge(credit_card)
  end

  def subscription
    if free_trial?
      @subscription = FreeTrial.new
    else
      @subscription ||= NoSubscription.new
    end
  end

  private

  def free_trial?
    created_at >= 30.days.ago
  end
end
