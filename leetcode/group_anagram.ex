defmodule GroupAnagram do
  def group(strs) do
    do_group(strs, %{})
    |> Enum.flat_map(fn {_, value} -> [value] end)
  end

  defp do_group([], accumulator), do: accumulator
  defp do_group([head | tail], accumulator) do
    key =
      String.to_charlist(head)
    |> Enum.sort()

    case Map.fetch(accumulator, key) do
      {:ok, _} ->
        accumulator = Map.update(accumulator, key, head, fn list ->
          [head | list]
        end)

        do_group(tail, accumulator)
      :error ->
        accumulator = Map.put(accumulator, key, [head | []])

        do_group(tail, accumulator)
    end
  end
end
