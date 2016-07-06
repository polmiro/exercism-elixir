defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    base = normalize(base)
    sorted_base = Enum.sort(base)
    Enum.filter(candidates, &anagram?(&1, base, sorted_base))
  end

  defp anagram?(candidate, base, sorted_base) do
    candidate = normalize(candidate)
    base != candidate && sorted_base == Enum.sort(candidate)
  end

  defp normalize(str) do
    str |> String.downcase |> String.codepoints
  end
end
