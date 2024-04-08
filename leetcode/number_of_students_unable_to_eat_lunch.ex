defmodule NumberOfStudentsUnableToEatLunch do
  def count_students(students, sandwiches) do
    students_eaten = do_count(students, sandwiches, 0) |> dbg()

    Enum.count(students) - students_eaten
  end

  defp do_count([], [], accu), do: accu

  defp do_count([student | students], [student | sandwiches], accu),
    do: do_count(students, sandwiches, accu + 1)

  defp do_count([student | students], [sandwich | sandwiches], accu) do
    student_map = MapSet.new([student | students]) |> dbg()
    sandwich_map = MapSet.new([sandwich | sandwiches]) |> dbg()
    [student | students] |> dbg()
    [sandwich | sandwiches] |> dbg()
    accu |> dbg()

    if Enum.count(student_map) < Enum.count(sandwich_map) ||
         (Enum.count(student_map) == Enum.count(sandwich_map) && student_map != sandwich_map) do
      do_count([], [], accu)
    else
      do_count(students ++ [student | []], [sandwich | sandwiches], accu)
    end
  end
end
