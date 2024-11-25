defmodule LibraryFees do
  def datetime_from_string(string) do
    case NaiveDateTime.from_iso8601(string) do
      {:ok, datetime} -> datetime
      {:error, reason} -> raise ArgumentError, "Invalid datetime string: #{reason}"
    end
  end

  def before_noon?(datetime) do
    r = NaiveDateTime.beginning_of_day(datetime)
    |> NaiveDateTime.add(12, :hour)
    |> NaiveDateTime.compare(datetime)

    case r do
      :lt -> false
      :gt -> true
      :eq -> false
    end
  end

  def return_date(checkout_datetime) do
    r = case before_noon?(checkout_datetime) do
      true -> NaiveDateTime.add(checkout_datetime, 28, :day)
      false -> NaiveDateTime.add(checkout_datetime, 29, :day)
    end
    NaiveDateTime.to_date(r)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    NaiveDateTime.to_date(actual_return_datetime)
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    NaiveDateTime.to_date(datetime)
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    return_datetime = datetime_from_string(return)
    checkout_datetime = datetime_from_string(checkout)

    days_late =
      checkout_datetime
      |> return_date()
      |> days_late(return_datetime)

      if monday?(return_datetime) do
        trunc(days_late * rate * 0.5)
      else
        days_late * rate
      end
  end
end
