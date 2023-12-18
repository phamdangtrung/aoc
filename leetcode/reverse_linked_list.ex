defmodule ReverseLinkedList do
  defp do_reverse([a], accu), do: [a | accu]
  defp do_reverse([head | tail], accu), do: reverse(tail, [head | accu])
  def reverse(list, accu \\ []) when is_list(list) do
    do_reverse(list, accu)
  end
end
