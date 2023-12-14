defmodule TrebuchetAgent do
  use Agent
  @word_dict %{
    "e" => [%{word: "eight", length: 5, value: 8}],
    "f" => [%{word: "four", length: 4, value: 4}, %{word: "five", length: 5, value: 5}],
    "n" => [%{word: "nine", length: 4, value: 9}],
    "o" => [%{word: "one", length: 3, value: 1}],
    "s" => [%{word: "six", length: 3, value: 6}, %{word: "seven", length: 5, value: 7}],
    "t" => [%{word: "two", length: 3, value: 2}, %{word: "three", length: 5, value: 3}]
  }

  def start_link(list) when is_list(list) do
    Agent.start_link(fn -> %{
      node: [],
      remaining_items: list
    } end)
  end

  def count(pid) do
    calculate(pid)
    get_node(pid)
  end

  def stop(pid) do
    Agent.stop(pid)
  end

  defp get_state(pid) do
    Agent.get(pid, fn state -> state end)
  end

  defp shift_nth_level(pid, levels) when is_integer(levels) and levels > 0 do
    Agent.update(pid, fn state ->
      %{state | remaining_items: state.remaining_items
      |> Enum.slice(levels..length(state.remaining_items))}
    end)
  end

  defp calculate(pid) do
    state = get_state(pid)
    if length(state.remaining_items) == 0 do
      state
    else
      [head | tail] = state.remaining_items

      if match_integer(head) do
        append_node(pid, String.to_integer(head))
      end

      if match_word_dict(head) do
        possible_outcomes = get_word_dict(head)

        Enum.map(possible_outcomes, fn possible_match ->
          if length(tail) >= possible_match.length - 1 do
            [needed_values | _] = Enum.chunk_every(tail, possible_match.length - 1, 1, :discard)
            temp_str =
              (head <> List.to_string(needed_values))

            if possible_match.word == temp_str do
              append_node(pid, possible_match.value)
              shift_nth_level(pid, possible_match.length)
              calculate(pid)
            end
          end
        end)
      end
      shift_nth_level(pid, 1)
      calculate(pid)
    end
  end

  defp get_node(pid) do
    Agent.get(pid, fn state -> %{head: List.last(state.node), last: List.first(state.node)} end)
  end

  defp match_integer(char) do
    regexp = ~r/[0-9]/

    String.match?(char, regexp)
  end

  defp match_word_dict(char) do
    case get_word_dict(char) do
      nil -> false
      _ -> true
    end
  end

  defp get_word_dict(key), do: @word_dict[key]

  defp append_node(pid, value) do
    Agent.update(pid, fn state ->
      %{state | node: [value | state.node]}
    end)
  end
end
