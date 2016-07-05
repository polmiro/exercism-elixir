defmodule Bob do
  def hey(input) do
    cond do
      silent?(input) -> "Fine. Be that way!"
      asking(input) -> "Sure."
      yelling?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp asking(str) do
    String.ends_with?(str, "?")
  end

  defp yelling?(str) do
    str == String.upcase(str) && str != String.downcase(str)
  end

  defp silent?(str) do
    String.strip(str) == ""
  end
end
