defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1, 2, 3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) when list == [], do: []
  def flatten(list) do
    list
    |> List.flatten()
    |> Enum.filter(fn el -> el != nil end)
  end
end
