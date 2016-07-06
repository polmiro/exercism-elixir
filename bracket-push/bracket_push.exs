defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str), do: str |> String.codepoints |> balanced?([])
  defp balanced?([], []), do: true  # finished right
  defp balanced?([], _),  do: false # finished wrong
  defp balanced?([c|remainder], stack) when c in ["(", "[", "{"], do: balanced?(remainder, [c|stack]) # opening
  defp balanced?([")"|remainder], ["("|stack]), do: balanced?(remainder, stack)  # closing right
  defp balanced?(["]"|remainder], ["["|stack]), do: balanced?(remainder, stack)  # closing right
  defp balanced?(["}"|remainder], ["{"|stack]), do: balanced?(remainder, stack)  # closing right
  defp balanced?([c|_], _) when c in [")", "]", "}"], do: false                  # closing wrong
  defp balanced?([_|remainder], stack), do: balanced?(remainder, stack)          # ignore other values
end
