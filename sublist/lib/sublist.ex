defmodule Sublist do
  @type equivalence :: :equal | :superlist | :sublist | :unequal

  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  @spec compare(list(), list()) :: equivalence()
  def compare([], []), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(a, b) do
    cond do
      a == b -> :equal
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      b != b -> :unequal
      true -> :unequal
    end
  end

  defp sublist?([], _), do: true
  defp sublist?(_, []), do: false

  defp sublist?(a, [h2 | t2]) do
    if starts_with?(a, [h2 | t2]) do
      true
    else
      sublist?(a, t2)
    end
  end

  defp starts_with?([], _), do: true
  defp starts_with?(_, []), do: false
  defp starts_with?([h1 | t1], [h2 | t2]) when h1 === h2, do: starts_with?(t1, t2)
  defp starts_with?(_, _), do: false
end
