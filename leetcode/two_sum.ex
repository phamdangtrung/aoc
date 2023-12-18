defmodule TwoSum do
  def sum(list, target) do
    list
    |> Enum.with_index()
    |> recurse(target, [])
  end

  defp recurse(_, _, [a, b]), do: [a, b]
  defp recurse([], _, _), do: :not_found

  defp recurse([{value, index} | tail], target, _) do
    recurse(tail, target, remainder(tail, target - value, [index]))
  end

  defp remainder([], _, accu), do: accu
  defp remainder([{target, index} | _], target, accu), do: [index | accu]
  defp remainder([_ | tail], target, accu), do: remainder(tail, target, accu)
end
