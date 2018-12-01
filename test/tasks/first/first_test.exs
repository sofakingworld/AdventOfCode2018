defmodule FirstTest do
  use ExUnit.Case

  test "+1, +1, +1 eq 3" do
    assert First.puzzle_one("+1, +1, +1") == 3
  end

  test "+1, +1, -2 eq 0" do
    assert First.puzzle_one("+1, +1, -2") == 0
  end
 
  test "-1, -2, -3 eq -6" do
    assert First.puzzle_one("-1, -2, -3") == -6
  end
end
