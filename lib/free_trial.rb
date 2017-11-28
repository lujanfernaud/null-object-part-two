class FreeTrial < NoSubscription
  def has_mentoring?
    true
  end

  def plan_name
    'Free Trial'
  end
end
