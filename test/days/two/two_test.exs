defmodule Days.TwoTest do
  alias Days.Two
  use ExUnit.Case

  test "puzzle_one:calculates ID's checksum" do
    data = ~s(
      abcdef
      bababc
      abbcde
      abcccd
      aabcdd
      abcdee
      ababab
    )
    assert Two.puzzle_one(data) == 12
  end

  test "pizzle_two: " do
    data = ~s(
      abcde
      fghij
      klmno
      pqrst
      fguij
      axcye
      wvxyz
    )

    assert Two.puzzle_two(data) == "fgij"
  end
end
