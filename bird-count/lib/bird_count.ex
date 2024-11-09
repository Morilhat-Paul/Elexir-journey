defmodule BirdCount do
  def today(list) when list == [], do: nil
    def today([head | _tail]) do
    head
  end

  def increment_day_count(list) when list == [], do: [1]
  def increment_day_count([head | tail]) do
    new_head = head + 1
    [new_head | tail]
  end

  def has_day_without_birds?(list) when list == [], do: false
  def has_day_without_birds?(list) do
    0 in list
  end

  def total(list) when list == [], do: 0
  def total(list) do
    [_head | tail] = list
    today(list) + total(tail)
  end

  def busy_days(list) when list == [], do: 0
  def busy_days(list) do
    [_head | tail] = list
    if today(list) >= 5 do
      1 + busy_days(tail)
    else
      0 + busy_days(tail)
    end
  end
end
