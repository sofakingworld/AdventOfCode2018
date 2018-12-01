defmodule Days.FirstTest do
  alias Days.First
  use ExUnit.Case

  test "puzzle_one: +1, +1, +1 eq 3" do
    assert First.puzzle_one("+1, +1, +1") == 3
  end

  test "puzzle_one: +1, +1, -2 eq 0" do
    assert First.puzzle_one("+1, +1, -2") == 0
  end

  test "puzzle_one: -1, -2, -3 eq -6" do
    assert First.puzzle_one("-1, -2, -3") == -6
  end

  test "puzzle_two: +1, -1 first reaches 0 twice." do
    assert First.puzzle_two(" +1, -1") == 0
  end

  test "puzzle_two: +3, +3, +4, -2, -4 first reaches 10 twice." do
    assert First.puzzle_two(" +3, +3, +4, -2, -4") == 10
  end

  test "puzzle_two: -6, +3, +8, +5, -6 first reaches 5 twice." do
    assert First.puzzle_two(" -6, +3, +8, +5, -6") == 5
  end

  test "puzzle_two: +7, +7, -2, -7, -4 first reaches 14 twice." do
    assert First.puzzle_two(" +7, +7, -2, -7, -4") == 14
  end
end
