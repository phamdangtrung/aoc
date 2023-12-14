defmodule Trebuchet do
  alias TrebuchetAgent
  def calculate_nodes(multi_line_string) when is_binary(multi_line_string) do
    String.split(multi_line_string, "\n")
    |> Enum.map(&find_head_tail(&1))
  end

  defp find_head_tail(string) when is_binary(string) do
    {:ok, pid} =
      string
      |> String.graphemes()
      |> TrebuchetAgent.start_link()

    %{head: head, last: last} = TrebuchetAgent.count(pid)
    TrebuchetAgent.stop(pid)
    %{head: head, last: last}
  end
end
