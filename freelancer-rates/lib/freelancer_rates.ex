defmodule FreelancerRates do
  @daily_rate_multiplier 8.0
  @billable_days_per_month 22.0

  def daily_rate(hourly_rate) do
    hourly_rate * @daily_rate_multiplier
  end

  def apply_discount(before_discount, discount) do
    before_discount - (before_discount * (discount / 100))
  end

  def monthly_rate(hourly_rate, discount) do
    daily_rate = daily_rate(hourly_rate)
    result = apply_discount(daily_rate * @billable_days_per_month, discount)
    trunc(Float.ceil(result))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate = daily_rate(hourly_rate)
    daily_rate_discounted = apply_discount(daily_rate, discount)
    result = budget / daily_rate_discounted
    Float.floor(result, 1)
  end
end
