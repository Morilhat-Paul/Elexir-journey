defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_unit, volume} = volume_pair
    volume
  end

  def to_milliliter(volume_pair) do
    {unit, volume} = volume_pair
    case unit do
      :milliliter -> {:milliliter, volume}
      :cup -> {:milliliter, volume * 240}
      :fluid_ounce -> {:milliliter, volume * 30}
      :teaspoon -> {:milliliter, volume * 5}
      :tablespoon -> {:milliliter, volume * 15}
    end
  end

  def from_milliliter(volume_pair, unit) do
    volume = get_volume(volume_pair)
    case unit do
      :milliliter -> {unit, volume}
      :cup -> {unit, volume / 240}
      :fluid_ounce -> {unit, volume / 30}
      :teaspoon -> {unit, volume / 5}
      :tablespoon -> {unit, volume / 15}
    end
  end

  def convert(volume_pair, unit) do
    milliliter = to_milliliter(volume_pair)
    from_milliliter(milliliter, unit)
  end
end
