defmodule Game do
  def new() do
    []
  end

  def roll([], pins) do
    [Frame.new(pins)]
  end

  def roll(game, pins) do
    Frame.complete?(last_set(game))
     |> add_frame(game, pins)
  end

  def score([]) do
    0
  end

  def score(game) when length(game)>1 do
    [last_frame | rest] = Enum.reverse(game)
    [previous_frame | _] = rest
    score( total(last_frame, previous_frame.first, previous_frame.second), rest )
  end

  def score(game) do
    last_frame = last_set(game)
    score( total(last_frame), [] )
  end

  def score(acc, []) do
    acc
  end

  def score(acc, game) when length(game)>1 do
    [last_frame | rest] = game
    [previous_frame | _ ] = rest
    score(acc + total(last_frame, previous_frame.first, previous_frame.second), rest )
  end


  def score(acc, game) do
    last_frame = last_set(game)
    score(acc + total(last_frame), [] )
  end

  defp total(last_frame, 10, nil) do
    Frame.total(last_frame)*2
  end

  defp total(last_frame, first, second) when first+second==10 do
    Frame.total(last_frame)+last_frame.first
  end

  defp total(frame, _, _) do
    Frame.total(frame)
  end

  defp total(frame) do
    Frame.total(frame)
  end

  defp add_frame(false, game, pins) do
    List.replace_at(game, -1, Frame.add_roll(last_set(game), pins))
  end

  defp add_frame(true,game, pins) do
    game ++ [Frame.new(pins)]
  end

  defp last_set(game) do
    List.last(game)
  end
end
