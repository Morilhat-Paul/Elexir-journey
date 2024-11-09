defmodule RPG.CharacterSheet do
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  def ask_name() do
    IO.gets("What is your character's name?\n")
    |> String.trim_leading()
    |> String.trim_trailing()
  end

  def ask_class() do
    IO.gets("What is your character's class?\n")
    |> String.trim_leading()
    |> String.trim_trailing()
  end

  def ask_level() do
    IO.gets("What is your character's level?\n")
    |> String.trim_leading()
    |> String.trim_trailing()
    |> String.to_integer()
  end

  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()
    IO.inspect(%{name: name, class: class, level: level}, label: "Your character")
  end
end
