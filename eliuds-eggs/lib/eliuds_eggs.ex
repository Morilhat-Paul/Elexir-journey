defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(0), do: 0
  def egg_count(number) do
    number
    |> Integer.to_string(2)
    |> String.graphemes()
    |> Enum.count(fn letter -> letter == "1" end)
  end
end
