defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
        ?A -> 0b0001
        ?C -> 0b0010
        ?G -> 0b0100
        ?T -> 0b1000
        _ -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
     0b0001 -> ?A
     0b0010 -> ?C
     0b0100 -> ?G
     0b1000 -> ?T
      _ -> ?\s
  end
  end

  def encode(dna) do
    encode_binary(dna, <<>>)
  end

  defp encode_binary([], acc), do: acc
  defp encode_binary([decoded | rest], acc) do
    nucleotide = encode_nucleotide(decoded)
    encode_binary(rest, <<acc::bitstring, nucleotide::4>>)
  end

  def decode(dna) do
    decode_binary(dna, [])
  end

  defp decode_binary(<<>>, acc), do: acc
  defp decode_binary(<<encoded::4, rest::bitstring>>, acc) do
    nucleotide = decode_nucleotide(encoded)
    decode_binary(rest, acc ++ [nucleotide])
  end
end
