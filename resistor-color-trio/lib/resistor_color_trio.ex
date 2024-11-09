defmodule ResistorColorTrio do
  @resistor_value %{
    :black => 0,
    :brown => 1,
    :red => 2,
    :orange => 3,
    :yellow => 4,
    :green => 5,
    :blue => 6,
    :violet => 7,
    :grey => 8,
    :white => 9
  }
  @giga 1_000_000_000
  @mega 1_000_000
  @kilo 1_000

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do

    first_value = Map.get(@resistor_value, Enum.at(colors, 0))
    second_value = Map.get(@resistor_value, Enum.at(colors, 1))
    third_value = Map.get(@resistor_value, Enum.at(colors, 2))

    value = first_value * 10 + second_value
    value = value * Integer.pow(10, third_value)

    cond do
      value >= @giga -> {value / @giga, :gigaohms}
      value >= @mega -> {value / @mega, :megaohms}
      value >= @kilo -> {value / @kilo, :kiloohms}
      true -> {value, :ohms}
    end
  end
end
