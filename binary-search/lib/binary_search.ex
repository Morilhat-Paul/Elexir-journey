defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, _) when tuple_size(numbers) == 0, do: :not_found
  def search(numbers, key) when tuple_size(numbers) == 1 do
    cond do
      elem(numbers, 0) == key -> {:ok, 0}
      true -> :not_found
    end
  end
  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  @spec search(tuple, integer, integer, integer) :: {:ok, integer} | :not_found
  defp search(_, _, min, max) when max < min, do: :not_found
  defp search(numbers, key, min, max) do
    mid = Integer.floor_div(min + max, 2)
    value = elem(numbers, mid)

    cond do
      value > key ->
        search(numbers, key, min, mid - 1)

      value < key ->
        search(numbers, key, mid + 1, max)

      value == key ->
        {:ok, mid}
    end
  end
end
