defmodule DayOne do
  alias Trebuchet
  def calibrate(multi_line_string) do
    addition = fn %{head: head, last: last}, accumulator ->
      String.to_integer("#{head}#{last}") + accumulator
    end

    Trebuchet.calculate_nodes(multi_line_string) |> dbg()
    |> Enum.reduce(0, addition)
  end
end
