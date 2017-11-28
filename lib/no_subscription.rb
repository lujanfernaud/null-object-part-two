class NoSubscription
  def has_mentoring?
    false
  end

  def charge(_credit_card)
    false
  end

  def price
    0
  end

  def plan_name
    'No Plan'
  end
end
