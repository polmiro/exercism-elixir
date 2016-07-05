defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> normalize
    |> split
    |> count_words
  end

  defp normalize(str) do
    String.downcase(str)
    |> String.replace(~r/[:!&@$%^,]/, "")
    |> String.replace(~r/_/, " ")
  end

  defp split(str) do
    String.split(str, ~r/\s+/)
  end

  defp count_words(words) do
    Enum.reduce(words, %{}, &count_reducer/2)
  end

  def count_reducer(x, acc) do
    Map.merge(acc, %{x => 1}, &count_sum/3)
  end

  defp count_sum(_, v1, v2) do
    v1 + v2
  end
end
