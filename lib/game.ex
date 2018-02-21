defmodule Game do
  def new() do
    []
  end

  def roll([], pins) do
    [[pins]]
  end

  def roll(game, pins) do
    length(last_set(game))
     |> add_frame(game, pins)
  end

  def score([]) do
    0
  end

  def score(game) when length(game)>1 do
    [last_frame | rest] = Enum.reverse(game)
    [previous_frame | _] = rest
    [first, second] = previous_frame
    score( total(last_frame, first,second), rest )
  end

  def score(game) do
    last_frame = List.last(game)
    score( total(last_frame), [] )
  end

  def score(acc, []) do
    acc
  end

  def score(acc, game) when length(game)>1 do
    [last_frame | rest] = Enum.reverse(game)
    [previous_frame | _ ] = rest
    [first, second] = previous_frame
    score(acc + total(last_frame, first,second), rest )
  end


  def score(acc, game) do
    last_frame = List.last(game)
    score(acc + total(last_frame), [] )
  end

  defp total(last_frame, 10, nil) do
    Enum.sum(last_frame)*2
  end

  defp total(last_frame, first, second) when first+second==10 do
    [one, two] = last_frame
    (one*2)+two
  end

  defp total(frame, _, _) do
    Enum.sum(frame)
  end

  defp total ([10, nil]) do
    10
  end

  defp total(frame) do
    Enum.sum(frame)
  end

  defp add_frame(size=1, game, pins) do
    List.replace_at(game, -1, last_set(game) ++ [pins])
  end

  defp add_frame(size=2,game, pins=10) do
    game ++ [[pins, nil]]
  end

  defp add_frame(size=2,game, pins) do
    game ++ [[pins]]
  end

  defp add_frame_to_total(frame=[10, nil], total) do
    total+10
  end

  defp add_frame_to_total(frame, total) do
    total + Enum.sum(frame)
  end

  defp last_set(game) do
    List.last(game)
  end
end
