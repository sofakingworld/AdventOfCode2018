defmodule Days.Three do
  @moduledoc false

  @parse_regex ~r/#(?'id'\d+) @ (?'left'\d+),(?'top'\d+): (?'width'\d+)x(?'height'\d+)/

  @doc """
  --- Day 3: No Matter How You Slice It ---
  The Elves managed to locate the chimney-squeeze prototype fabric for Santa's suit (thanks to someone who helpfully wrote its box IDs on the wall of the warehouse in the middle of the night). Unfortunately, anomalies are still affecting them - nobody can even agree on how to cut the fabric.

  The whole piece of fabric they're working on is a very large square - at least 1000 inches on each side.

  Each Elf has made a claim about which area of fabric would be ideal for Santa's suit. All claims have an ID and consist of a single rectangle with edges parallel to the edges of the fabric. Each claim's rectangle is defined as follows:

  The number of inches between the left edge of the fabric and the left edge of the rectangle.
  The number of inches between the top edge of the fabric and the top edge of the rectangle.
  The width of the rectangle in inches.
  The height of the rectangle in inches.
  A claim like #123 @ 3,2: 5x4 means that claim ID 123 specifies a rectangle 3 inches from the left edge, 2 inches from the top edge, 5 inches wide, and 4 inches tall. Visually, it claims the square inches of fabric represented by # (and ignores the square inches of fabric represented by .) in the diagram below:

  ...........
  ...........
  ...#####...
  ...#####...
  ...#####...
  ...#####...
  ...........
  ...........
  ...........
  The problem is that many of the claims overlap, causing two or more claims to cover part of the same areas. For example, consider the following claims:

  #1 @ 1,3: 4x4
  #2 @ 3,1: 4x4
  #3 @ 5,5: 2x2
  Visually, these claim the following areas:

  ........
  ...2222.
  ...2222.
  .11XX22.
  .11XX22.
  .111133.
  .111133.
  ........
  The four square inches marked with X are claimed by both 1 and 2. (Claim 3, while adjacent to the others, does not overlap either of them.)

  If the Elves all proceed with their own plans, none of them will have enough fabric. How many square inches of fabric are within two or more claims?
  """
  def puzzle_one(input_data) do
    input_data
    |> String.split("\n", trim: true)
    |> Enum.map(&string_to_fabric_struct/1)
    |> Enum.map(&get_fabric_field/1)
    |> List.flatten()
    |> Enum.reduce(%{}, fn fabric, global_area -> put_fabric(global_area, fabric) end)
    |> Map.values()
    |> Enum.filter(fn ids_list -> length(ids_list) > 1 end)
    |> length()
  end
  
  
  # Converts data string to Map 
  # Example: converts "#2 @ 3,1: 4x4" to %{id: 2, left: 3, top: 1, width: 4, height: 4}
  defp string_to_fabric_struct(string) do
    @parse_regex
    |> Regex.named_captures(string)
    |> Enum.map(fn {k, v} -> {k, String.to_integer(v)} end)
    |> Map.new()
  end

  # returns coordinates for fabric
  # %{{x, y} => fabric_id}
  # Example for claim: %{id: 2, left: 3, top: 1, width: 1, height: 1}
  # returns %{{3, 1} => 2}
  defp get_fabric_field(%{"id" => id, "left" => left, "top" => top, "width" => width, "height" => height}) do
    for x <- (1..width) do
      for y <- (1..height) do
        %{{x + left, y + top} => [id]}
      end
    end
  end

  # if there are overlaps on coordinate fields -> fabric's ids will be putted in list
  defp put_fabric(global_area, fabric) do
    Map.merge(global_area, fabric, fn _k, v1, v2 ->
      v1 ++ v2
    end)
  end

  @doc """
  --- Part Two ---
  Amidst the chaos, you notice that exactly one claim doesn't overlap by even a single square inch of fabric with any other claim. If you can somehow draw attention to it, maybe the Elves will be able to make Santa's suit after all!

  For example, in the claims above, only claim 3 is intact after all claims are made.

  What is the ID of the only claim that doesn't overlap?
  """
  def puzzle_two(input_data) do
    claims = 
      input_data
      |> String.split("\n", trim: true)
      |> Enum.map(&string_to_fabric_struct/1)
      |> Enum.map(fn struct -> struct["id"] end)

    overlaped_claims = 
      input_data
      |> String.split("\n", trim: true)
      |> Enum.map(&string_to_fabric_struct/1)
      |> Enum.map(&get_fabric_field/1)
      |> List.flatten()
      |> Enum.reduce(%{}, fn fabric, global_area -> put_fabric(global_area, fabric) end)
      |> Map.values()
      |> Enum.filter(fn ids_list -> length(ids_list) > 1 end)
      |> List.flatten()
      |> Enum.uniq()
    
    not_overlaped_claims = claims -- overlaped_claims
    List.first(not_overlaped_claims)
  end
end