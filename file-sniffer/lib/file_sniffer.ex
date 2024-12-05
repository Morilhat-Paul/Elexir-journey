defmodule FileSniffer do
  @spec type_from_extension(String.t()) :: String.t() | nil
  def type_from_extension(extension) do
      case extension do
        "exe" -> "application/octet-stream"
        "bmp" -> "image/bmp"
        "png" -> "image/png"
        "jpg" -> "image/jpg"
        "gif" -> "image/gif"
        _ -> nil
    end
  end

  @spec type_from_binary(binary()) :: String.t() | nil
  def type_from_binary(file_binary) when not is_binary(file_binary), do: nil
  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _::bitstring>>), do: "application/octet-stream"
  def type_from_binary(<<0x42, 0x4D, _::bitstring>>), do: "image/bmp"
  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::bitstring>>), do: "image/png"
  def type_from_binary(<<0xFF, 0xD8, 0xFF, _::bitstring>>), do: "image/jpg"
  def type_from_binary(<<0x47, 0x49, 0x46, _::bitstring>>), do: "image/gif"
  def type_from_binary(_), do: nil

  @spec verify(binary(), String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def verify(file_binary, extension) do
    type = type_from_binary(file_binary)
    if  type != nil and type == type_from_extension(extension) do
      {:ok, type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
