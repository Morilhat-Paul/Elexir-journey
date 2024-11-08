defmodule Lasagna do
  @cooking_time 40
  @layer_time 2

  def expected_minutes_in_oven do
    @cooking_time
  end

  def remaining_minutes_in_oven(minutes) do
    expected_minutes_in_oven() - minutes
  end

  def preparation_time_in_minutes(layers) do
    @layer_time * layers
  end

  def total_time_in_minutes(layers, minutes) do
    preparation_time_in_minutes(layers) + minutes
  end

  def alarm do
    "Ding!"
  end
end
