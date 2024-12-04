defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(_, locale, entries) when entries == [], do: get_header(locale)
  def format_entries(currency, locale, entries) do
    header = get_header(locale)
    entries = get_entries(currency, locale, entries)
    header <> entries <> "\n"
  end

  @spec get_header(locale()) :: String.t()
  defp get_header(locale) do
    case locale do
      :en_US -> "Date       | Description               | Change       \n"
      :nl_NL -> "Datum      | Omschrijving              | Verandering  \n"
    end
  end

  @spec get_entries(currency(), locale(), list(entry())) :: String.t()
  defp get_entries(currency, locale, entries) do
    Enum.sort(entries, fn a, b ->
      cond do
        a.date.day < b.date.day -> true
        a.date.day > b.date.day -> false
        a.description < b.description -> true
        a.description > b.description -> false
        true -> a.amount_in_cents <= b.amount_in_cents
      end
    end)
    |> Enum.map(fn entry -> format_entry(currency, locale, entry) end)
    |> Enum.join("\n")
  end

  @spec format_entry(currency(), locale(), entry()) :: String.t()
  defp format_entry(currency, locale, entry) do
    date = format_date(entry.date, locale)
    description = format_description(entry.description)
    amount =
      entry.amount_in_cents
      |> format_number(locale)
      |> format_amount(entry.amount_in_cents, currency, locale)

    date <> "|" <> description <> " |" <> amount
  end

  @spec format_date(Date.t(), locale()) :: String.t()
  defp format_date(date, locale) do
    year = date.year |> to_string()
    month = date.month |> to_string() |> String.pad_leading(2, "0")
    day = date.day |> to_string() |> String.pad_leading(2, "0")

    case locale do
      :en_US -> month <> "/" <> day <> "/" <> year <> " "
      :nl_NL -> day <> "-" <> month <> "-" <> year <> " "
    end
  end

  @spec format_number(integer(), locale()) :: String.t()
  defp format_number(amount_in_cents, locale) do
    if locale == :en_US do
      decimal =
        amount_in_cents |> abs |> rem(100) |> to_string() |> String.pad_leading(2, "0")

      whole =
        if abs(div(amount_in_cents, 100)) < 1000 do
          abs(div(amount_in_cents, 100)) |> to_string()
        else
          to_string(div(abs(div(amount_in_cents, 100)), 1000)) <>
            "," <> to_string(rem(abs(div(amount_in_cents, 100)), 1000))
        end

      whole <> "." <> decimal
    else
      decimal =
        amount_in_cents |> abs |> rem(100) |> to_string() |> String.pad_leading(2, "0")

      whole =
        if abs(div(amount_in_cents, 100)) < 1000 do
          abs(div(amount_in_cents, 100)) |> to_string()
        else
          to_string(div(abs(div(amount_in_cents, 100)), 1000)) <>
            "." <> to_string(rem(abs(div(amount_in_cents, 100)), 1000))
        end

      whole <> "," <> decimal
    end
  end

  @spec format_amount(integer(), integer(), currency(), locale()) :: String.t()
  defp format_amount(number, amount_in_cents, currency, locale) do
    if amount_in_cents >= 0 do
      case locale do
        :en_US -> "  #{if(currency == :eur, do: "€", else: "$")}#{number} "
        :nl_NL -> " #{if(currency == :eur, do: "€", else: "$")} #{number} "
      end
    else
      case locale do
        :en_US -> " (#{if(currency == :eur, do: "€", else: "$")}#{number})"
        :nl_NL -> " #{if(currency == :eur, do: "€", else: "$")} -#{number} "
      end
    end
    |> String.pad_leading(14, " ")
  end

  @spec format_description(String.t()) :: String.t()
  defp format_description(description) do
    if description |> String.length() > 26 do
      " " <> String.slice(description, 0, 22) <> "..."
    else
      " " <> String.pad_trailing(description, 25, " ")
    end
  end
end
