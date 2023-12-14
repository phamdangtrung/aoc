defmodule ContainsDuplicate do
  def contains_duplicate(nums), do: do_contains_duplicate(Enum.sort(nums))
  defp do_contains_duplicate([l]), do: false
  defp do_contains_duplicate([head | [head | tail]]), do: true
  defp do_contains_duplicate([head | tail]), do: do_contains_duplicate(tail)
end
