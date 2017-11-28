# Upcase Refactoring Trail

## Null Object (Part 2)

Refactoring exercise using the [Introduce Null Object](https://refactoring.com/catalog/introduceNullObject.html) refactoring for the [Upcase Refactoring Trail](https://thoughtbot.com/upcase/refactoring).

### Null Object

> You have repeated checks for a null value. Replace the null value with a null object. -- Martin Fowler

#### Before

```ruby
# user.rb

class User
  include ActiveModel::Model
  attr_accessor :created_at, :credit_card, :subscription

  FREE_TRIAL = 'Free Trial'
  NO_PLAN = 'No Plan'

  def charge
    unless subscription.nil?
      subscription.charge(credit_card)
    end
  end

  def has_mentoring?
    free_trial? || subscription && subscription.has_mentoring?
  end

  def price
    if free_trial? || subscription.nil?
      0
    else
      subscription.price
    end
  end

  def plan_name
    if free_trial?
      FREE_TRIAL
    elsif subscription
      subscription.plan_name
    else
      NO_PLAN
    end
  end

  private

  def free_trial?
    created_at >= 30.days.ago
  end
end
```

#### After

```ruby
# user.rb

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
```

```ruby
# free_trial.rb

class FreeTrial < NoSubscription
  def has_mentoring?
    true
  end

  def plan_name
    'Free Trial'
  end
end
```

```ruby
# no_subscription.rb

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
```
