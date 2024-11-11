defmodule LogParser do
  def valid_line?(line) do
    regex = ~r/^\[(DEBUG|INFO|WARNING|ERROR)\] ([\w ]*)/
    String.match?(line, regex)
  end

  def split_line(line) do
    regex = ~r/<([\~\*\=\-])*>/
    Regex.split(regex, line)
  end

  def remove_artifacts(line) do
    regex = ~r/(end-of-line)[[:digit:]]+/i
    String.replace(line, regex, "", global: true)
  end

  def tag_with_user_name(line) do
    regex = ~r/User\s+(?<user>\S+)/
    result = Regex.run(regex, line, capture: ["user"])
    if result != nil do
      "[USER] #{result} " <> line
    else
      line
    end
  end
end
