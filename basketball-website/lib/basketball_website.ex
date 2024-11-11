defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    [key | tail] = String.split(path, ".")
    if tail != [] do
      extract_from_path(data[key], Enum.join(tail, "."))
    else
      data[key]
    end
  end

  def get_in_path(data, path) do
    path_list = String.split(path, ".")
    Kernel.get_in(data, path_list)
  end
end
