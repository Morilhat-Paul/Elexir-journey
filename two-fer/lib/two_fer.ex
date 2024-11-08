defmodule TwoFer do
  @moduledoc """
  Determine what you will say as you give away the extra cookie.
  """
  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.
  """
  @spec two_fer(String.t()) :: String.t()
  def two_fer(name \\ "")

  def two_fer(name) when is_binary(name) and name == "" do
    "One for you, one for me."
  end

  def two_fer(name) when is_binary(name) do
    "One for #{name}, one for me."
  end
end
