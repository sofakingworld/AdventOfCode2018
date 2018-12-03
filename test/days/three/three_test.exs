defmodule Days.ThreeTest do
  alias Days.Three
  use ExUnit.Case

  test "puzzle_one, returns overlap count eq 4" do
    data = ~s(#1 @ 1,3: 4x4
              #2 @ 3,1: 4x4
              #3 @ 5,5: 2x2)
    assert Three.puzzle_one(data) == 4
  end

  test "puzzle_one, returns unoverlapped fabric ID and it eq 3" do
    data = ~s(#1 @ 1,3: 4x4
              #2 @ 3,1: 4x4
              #3 @ 5,5: 2x2)
    assert Three.puzzle_two(data) == 3
  end
end
