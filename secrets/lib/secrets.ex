defmodule Secrets do
  def secret_add(secret) do
    function = fn value -> value + secret  end
    function
  end

  def secret_subtract(secret) do
    function = fn value -> value - secret end
    function
  end

  def secret_multiply(secret) do
    function = fn value -> value * secret end
    function
  end

  def secret_divide(secret) do
    function = fn value -> div(value, secret) end
    function
  end

  def secret_and(secret) do
    function = fn value -> Bitwise.band(value, secret) end
    function
  end

  def secret_xor(secret) do
    function = fn value -> Bitwise.bxor(value, secret) end
    function
  end

  def secret_combine(secret_function1, secret_function2) do
    function = fn value ->
      result = secret_function1.(value)
      secret_function2.(result)
    end
    function
  end
end
