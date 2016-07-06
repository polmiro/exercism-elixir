defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) when nucleotide in @nucleotides, do: strand |> histogram |> Map.get(nucleotide)
  def count(_, nucleotide), do: raise(ArgumentError, message: "invalid nucleotide: #{nucleotide}")

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def  histogram(strand) do
    acc = Map.new(@nucleotides, fn k -> {k, 0} end)
    histogram_acc(strand, acc)
  end
  defp histogram_acc([], acc), do: acc
  defp histogram_acc([h|t], acc), do: histogram_acc(t, increment_histogram(acc, h))
  defp increment_histogram(acc, c) when c in @nucleotides, do: Map.update(acc, c, 0, &(&1+1))
  defp increment_histogram(_, c), do: raise(ArgumentError, message: "invalid nucleotide found in strand: #{c}")
end
