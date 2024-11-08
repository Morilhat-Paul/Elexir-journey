defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a, b) do
    {a1, b1} = a
    {a2, b2} = b
    r1 = (a1 * b2) + (a2 * b1)
    r2 = b1 * b2
    reduce({r1, r2})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, b) do
    {a1, b1} = a
    {a2, b2} = b
    r1 = (a1 * b2) - (a2 * b1)
    r2 = b1 * b2
    reduce({r1, r2})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(a, b) do
    {a1, b1} = a
    {a2, b2} = b
    r1 = a1 * a2
    r2 = b1 * b2
    reduce({r1, r2})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(num, den) do
    {a1, b1} = num
    {a2, b2} = den
    r1 = (a1 * b2)
    r2 = (a2 * b1)
    reduce({r1, r2})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a) do
    {a1, b1} = a
    r1 = Kernel.abs(a1)
    r2 = Kernel.abs(b1)
    reduce({r1, r2})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a, n) do
    {a, b} = a
    if n < 0 do
      m = Kernel.abs(n)
      r1 = Integer.pow(b, m)
      r2 = Integer.pow(a, m)
      reduce({r1, r2})
    else
      r1 = Integer.pow(a, n)
      r2 = Integer.pow(b, n)
      reduce({r1, r2})
    end
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
    {a, b} = n
    x_a = :math.pow(x, a)
    :math.pow(x_a, 1 / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce(a) do
    {a, b} = a
    gcd = Integer.gcd(a, b)
    {a, b} = if b < 0 do
      {-a, -b}
    else
      {a, b}
    end
    {div(a, gcd), div(b, gcd)}
  end
end
