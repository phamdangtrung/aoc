defmodule IsAnagram do
  def is_anagram(value, comparer) do
    ~c(value) |> Enum.sort() == ~c(comparer) |> Enum.sort()
  end
end
