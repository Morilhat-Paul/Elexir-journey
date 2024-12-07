defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factor_for(number, 2, [])
  end

  defp do_factor_for(1, _, factors), do: factors
  defp do_factor_for(number, divisor, factors) do
    cond do
      rem(number, divisor) == 0 ->
        do_factor_for(div(number, divisor), divisor, factors ++ [divisor])

      true ->
        do_factor_for(number, divisor + 1, factors)
    end
  end
end
