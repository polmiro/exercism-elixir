defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def  hamming_distance(strain1, strain2) when length(strain1) != length(strain2), do: {:error, "Lists must be the same length."}
  def  hamming_distance(strain1, strain2), do: {:ok, hamming_distance_num(strain1, strain2)}
  defp hamming_distance_num([], []), do: 0
  defp hamming_distance_num([h1|t1], [h2|t2]) do
    cond do
      h1 == h2 -> hamming_distance_num(t1, t2)
      true     -> 1 + hamming_distance_num(t1, t2)
    end
  end
end
