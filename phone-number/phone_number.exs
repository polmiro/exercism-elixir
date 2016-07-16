defmodule Phone do
  @length 10
  @country_code "1"
  @bad_number String.duplicate("0", @length)

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> normalize
    |> trim_leading_country_code
  end

  defp normalize(raw) do
    cond do
      String.match?(raw, ~r/[A-Za-z]+/) -> @bad_number
      true -> String.replace(raw, ~r{\D}, "")
    end
  end

  defp trim_leading_country_code(str) do
    cond do
      String.length(str) == @length -> str
      String.length(str) == @length + 1 && String.starts_with?(str, @country_code) -> String.slice(str, 1..-1)
      true -> @bad_number
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> number
    |> String.slice(0..2)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    raw
    |> number
    |> pretty_format
  end
  defp pretty_format(number) do
    "(#{String.slice(number, 0..2)}) #{String.slice(number, 3..5)}-#{String.slice(number, 6..9)}"
  end
end
