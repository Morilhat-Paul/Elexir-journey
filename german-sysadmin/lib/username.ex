defmodule Username do
  def sanitize(username) when username == ~c"", do: ~c""
  def sanitize(username) do
    username
    |> substitutes_german_letters()
    |> sanitize_letters()
    |> sanitize_numbers()
    |> sanitize_punctuation()
    |> sanitize_whitespace()
  end

  defp sanitize_letters(username) do
    Enum.filter(username, fn letter ->
      case (letter >= ?a and letter <= ?z)
        or letter == ?_ do
        false -> false
        true -> true
      end
    end)
  end

  defp sanitize_numbers(username) do
    Enum.filter(username, fn letter ->
      case letter >= ?0 and letter <= ?9 do
        false -> true
        true -> false
      end
    end)
  end

  defp sanitize_punctuation(username) do
    Enum.filter(username, fn letter ->
      case letter == ?*
        or letter == ?!
        or letter == ?$
        or letter == ?%
      do
        false -> true
        true -> false
      end
    end)
  end

  defp sanitize_whitespace(username) do
    Enum.filter(username, fn letter ->
      case letter == ~c" " do
        false -> true
        true -> false
      end
    end)
  end

  defp substitutes_german_letters(username) do
    Enum.flat_map(username, fn letter ->
      case letter do
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        _ -> [letter]
      end
    end)
  end
end
