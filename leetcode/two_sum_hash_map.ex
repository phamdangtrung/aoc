defmodule TwoSum do
  def sum(list, target) do
    num_list =
      list
      |> Enum.with_index()

    result =
      Enum.reduce_while(num_list, %{}, fn {value, index}, accumulator ->
        accumulator |> dbg()
        remainder = target - value

        if Map.get(accumulator, remainder) |> dbg() do
          {:halt, Map.put(accumulator, :answer, [Map.get(accumulator, remainder), index])}
        else
          {:cont, Map.put(accumulator, value, index)}
        end
      end)

    Map.get(result, :answer)
  end

  # defp find_two_sum(_, _, _, [a, b]), do: [a, b]
  # defp find_two_sum([], _, _, []), do: :not_found
  #
  # defp find_two_sum([{value, index} | tail], num_map, target, _) do
  #   search_result = Map.get(num_map, target - value)
  #
  #   num_map
  #   |> Map.drop()
  #
  #   if search_result && search_re do
  #     find_two_sum(tail, num_map, target, [index, search_result])
  #   else
  #     find_two_sum(tail, num_map, target, [])
  #   end
  # end
end
