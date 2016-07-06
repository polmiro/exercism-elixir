defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.codepoints
    |> rle([])
    |> Enum.map(&construct(&1))
    |> Enum.join
  end

  defp rle([], out), do: Enum.reverse(out)
  defp rle([x|src], [{c,x}|out]), do: rle(src, [{c+1,x}|out])
  defp rle([x|src], out), do: rle(src, [{1,x}|out])

  defp construct({count, letter}), do: "#{count}#{letter}"
  defp construct([]), do: ""

  @spec decode(String.t) :: String.t
  def decode(string) do
    ~r/(\d+)([^\d])/
    |> Regex.scan(string)
    |> Enum.map(&decode_part(&1))
    |> Enum.join
  end

  defp decode_part([_, cnt, letter]) do
    String.duplicate(letter, to_int(cnt))
  end

  defp to_int(str) do
    str |> Integer.parse |> elem(0)
  end
end
