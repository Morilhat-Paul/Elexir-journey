defmodule Darts do
  @type position :: {number, number}

  @outer_radius 10
  @middle_radius 5
  @inner_radius 1

  @no_point 0
  @outer_point 1
  @middle_point 5
  @inner_point 10

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score(position) do
    cond do
      in_inner_circle?(position) -> @inner_point
      in_middle_circle?(position) -> @middle_point
      in_outer_circle?(position) -> @outer_point
      true -> @no_point
    end
  end

  defp in_outer_circle?(position), do: get_distance(position) <= @outer_radius
  defp in_middle_circle?(position), do: get_distance(position) <= @middle_radius
  defp in_inner_circle?(position), do: get_distance(position) <= @inner_radius

  defp get_distance({x, y}) do
    :math.sqrt(x * x + y * y)
  end
end
