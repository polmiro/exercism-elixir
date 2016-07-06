defmodule DNA do
  @dna_to_rna_map Map.new([{?A, ?U}, {?C, ?G}, {?T, ?A}, {?G, ?C}])

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna([]), do: []
  def to_rna([h|t]) do
    [Map.get(@dna_to_rna_map, h)|to_rna(t)]
  end
end
