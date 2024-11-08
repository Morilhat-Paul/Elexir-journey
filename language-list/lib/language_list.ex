defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
    List.insert_at(list, 0, language)
  end

  def remove(list) do
    List.delete_at(list, 0)
  end

  def first(list) do
    List.first(list)
  end

  def count(list) do
    length(list)
  end

  def functional_list?(list) do
    "Elixir" in list
  end
end
