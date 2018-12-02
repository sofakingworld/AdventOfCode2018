defmodule Days.Two do
  @moduledoc false

  @doc """
  --- Day 2: Inventory Management System ---
  You stop falling through time, catch your breath, and check the screen on the device. "Destination reached. Current Year: 1518. Current Location: North Pole Utility Closet 83N10." You made it! Now, to find those anomalies.

  Outside the utility closet, you hear footsteps and a voice. "...I'm not sure either. But now that so many people have chimneys, maybe he could sneak in that way?" Another voice responds, "Actually, we've been working on a new kind of suit that would let him fit through tight spaces like that. But, I heard that a few days ago, they lost the prototype fabric, the design plans, everything! Nobody on the team can even seem to remember important details of the project!"

  "Wouldn't they have had enough fabric to fill several boxes in the warehouse? They'd be stored together, so the box IDs should be similar. Too bad it would take forever to search the warehouse for two similar box IDs..." They walk too far away to hear any more.

  Late at night, you sneak to the warehouse - who knows what kinds of paradoxes you could cause if you were discovered - and use your fancy wrist device to quickly scan every box and produce a list of the likely candidates (your puzzle input).

  To make sure you didn't miss any, you scan the likely candidate boxes again, counting the number that have an ID containing exactly two of any letter and then separately counting those with exactly three of any letter. You can multiply those two counts together to get a rudimentary checksum and compare it to what your device predicts.

  For example, if you see the following box IDs:

  abcdef contains no letters that appear exactly two or three times.
  bababc contains two a and three b, so it counts for both.
  abbcde contains two b, but no letter appears exactly three times.
  abcccd contains three c, but no letter appears exactly two times.
  aabcdd contains two a and two d, but it only counts once.
  abcdee contains two e.
  ababab contains three a and three b, but it only counts once.
  Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of 4 * 3 = 12.
  """
  def puzzle_one(input_data) do
    input_data
    |> String.split()
    |> Enum.map(fn string -> String.split(string, "", trim: true) end)
    |> Enum.map(&group_by_letter/1)
    |> Enum.map(&count_letter_inclusions/1)
    |> Enum.reduce([0, 0], fn group, [twice, three] ->
      appears_twice = letter_appears?(group, 2)
      appears_three = letter_appears?(group, 3)

      cond do
        appears_twice && appears_three -> [twice + 1, three + 1]
        appears_twice && !appears_three -> [twice + 1, three]
        !appears_twice && appears_three -> [twice, three + 1]
        true -> [twice, three]
      end
    end)
    |> Enum.reduce(1, fn qty, multiplier -> qty * multiplier end)
  end

  defp letter_appears?(group, appears_count) do
    group
    |> Enum.filter(fn {_letter, qty} -> qty == appears_count end)
    |> Enum.any?()
  end

  defp count_letter_inclusions(group) do
    group
    |> Enum.map(fn {letter, inclusions} -> {letter, length(inclusions)} end)
  end

  defp group_by_letter(letter_list) do
    letter_list
    |> Enum.group_by(fn letter -> letter end)
  end

  @doc """
  --- Part Two ---
  Confident that your list of box IDs is complete, you're ready to find the boxes full of prototype fabric.

  The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:

  abcde
  fghij
  klmno
  pqrst
  fguij
  axcye
  wvxyz
  The IDs abcde and axcye are close, but they differ by two characters (the second and fourth). However, the IDs fghij and fguij differ by exactly one character, the third (h and u). Those must be the correct boxes.

  What letters are common between the two correct box IDs? (In the example above, this is found by removing the differing character from either ID, producing fgij.)
  """
  def puzzle_two(input_data) do
    boxes =
      input_data
      |> String.split()
      |> Enum.with_index()

    for {id1, idx1} <- boxes do
      for {id2, idx2} <- boxes do
        case idx1 == idx2 do
          true -> nil
          false -> compare_difference(id1, id2)
        end
      end
    end
    |> List.flatten()
    |> Enum.filter(fn elem -> !is_nil(elem) end)
    |> Enum.filter(fn {diff_counter, _str} -> diff_counter == 1 end)
    |> Enum.map(fn {_diff_counter, str} -> str end)
    |> List.first()
  end

  defp compare_difference(id1, id2) do
    letters1 = String.split(id1, "", trim: true)
    letters2 = String.split(id2, "", trim: true)

    letters1
    |> Enum.with_index()
    |> Enum.reduce({0, ""}, fn {letter1, idx}, {diff_counter, result_string} ->
      letter2 = Enum.at(letters2, idx)

      case letter1 == letter2 do
        true -> {diff_counter, result_string <> letter1}
        false -> {diff_counter + 1, result_string}
      end
    end)
  end
end
