defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      String.match?(input, ~r/^\s*$/) ->
        "Fine. Be that way!"

      String.match?(input, ~r/[[:alpha:]]\?\s*$/) and
      input == String.upcase(input, :ascii) ->
        "Calm down, I know what I'm doing!"

      String.match?(input, ~r/[[:alpha:]]/) and
      input == String.upcase(input, :ascii) ->
        "Whoa, chill out!"

      String.match?(input, ~r/\?\s*$/) ->
        "Sure."

      true ->
        "Whatever."
    end
  end
end
