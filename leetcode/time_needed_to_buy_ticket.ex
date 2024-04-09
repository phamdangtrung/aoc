defmodule TimeNeededToBuyTicket do
  def time_required_to_buy(tickets, k) do
    rows = Enum.at(tickets, k)
    ticket_number = Enum.count(tickets)
    position = (Enum.at(tickets, k) - 1) * ticket_number + k + 1

    # first
    create_matrix(tickets, rows, [])
    |> Enum.take(position)
    |> Enum.sum()

    # second
    do_count(tickets, %{total: 0, count: 0}, position)
  end

  defp create_matrix(_, 0, matrix), do: matrix

  defp create_matrix(tickets, matrix_rows, matrix) do
    {new_matrix, new_tickets} =
      Enum.map_reduce(tickets, [], fn ele, acc ->
        if ele > 0 do
          {1, Enum.concat(acc, [ele - 1 | []])}
        else
          {0, Enum.concat(acc, [ele - 1 | []])}
        end
      end)

    create_matrix(new_tickets, matrix_rows - 1, Enum.concat(matrix, new_matrix))
  end

  defp do_count(_, accu, position) when accu.count > position, do: accu.total

  defp do_count(tickets, accu, position) do
    position |> dbg

    {new_tickets, accu} = Enum.map_reduce(tickets, accu, fn elem, accu ->
      if (elem > 0 && accu.count < position) do
        {elem - 1, %{accu | total: accu.total + 1, count: accu.count + 1}} |> dbg()
      else
        {elem, %{accu | count: accu.count + 1}} |> dbg()
      end
    end) |> dbg()

    do_count(new_tickets, accu, position)
  end
end
