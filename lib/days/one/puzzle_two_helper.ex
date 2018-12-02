defmodule Days.One.PuzzleTwoHelper do
  @moduledoc false

  def find_twiced_summary(all_elements, sums, []) do
    find_twiced_summary(all_elements, sums, all_elements)
  end

  def find_twiced_summary(all_elements, sums, [element]) do
    case reached_twice_strategy(sums, element) do
      {:halt, twice_reached_result} -> twice_reached_result
      {:cont, new_sums} -> find_twiced_summary(all_elements, new_sums, all_elements)
    end
  end

  def find_twiced_summary(all_elements, sums, [element | tail_elements] = current_elements) do
    case reached_twice_strategy(sums, element) do
      {:halt, twice_reached_result} -> twice_reached_result
      {:cont, new_sums} -> find_twiced_summary(all_elements, new_sums, tail_elements)
    end
  end

  def reached_twice_strategy(sums, element) do
    current_sum = List.last(sums) + element

    case current_sum in sums do
      true -> {:halt, current_sum}
      false -> {:cont, sums ++ [current_sum]}
    end
  end
end
