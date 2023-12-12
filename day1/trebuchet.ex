defmodule Trebuchet do
  defstruct [:num_point]

  def calculate_nodes(multi_line_string) when is_binary(multi_line_string) do
    String.split(multi_line_string, "\n")
    |> Enum.map(&find_head_tail(&1))
    |> Enum.reduce(0, fn x, acc ->
      case(x) do
        nil -> acc
        %Trebuchet{num_point: value} -> acc + value
      end
    end)
  end

  defp find_head_tail(string) when is_binary(string) do
    string
    |> String.graphemes()
    |> Enum.filter(&(!match_integer(&1)))
    |> create_node()
  end

  defp match_integer(char) do
    regexp = ~r/[0-9]/

    !String.match?(char, regexp)
  end

  defp create_node([]), do: nil

  defp create_node(num_map) do
    %Trebuchet{
      num_point: (List.first(num_map) <> List.last(num_map)) |> String.to_integer()
    }
  end
end
