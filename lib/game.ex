defmodule Game do
  def new() do
    []
  end

  def roll([], pins) do
    [Frame.new(pins)]
  end

  def roll(game, pins) when length(game)<=10 do
    Frame.complete?(length(game), last_set(game))
     |> add_frame(game, pins)
  end

  def roll(_, _) do
    raise "This game is finished!"
  end

  def score([]) do
    0
  end

  def score(game) when length(game)>=10 do
    [last_frame | rest] = Enum.reverse(game)
    [previous_frame | [frame_before_that | _]] = rest
    score( Frame.total(last_frame, (needs_doubling?(previous_frame, frame_before_that)), :final_frame), rest )
  end

  def score(game) when length(game)>2 do
    [last_frame | rest] = Enum.reverse(game)
    [previous_frame | [frame_before_that | _]] = rest
    score( Frame.total(last_frame, (needs_doubling?(previous_frame, frame_before_that))), rest )
  end

  def score(game) when length(game)>1 do
    [last_frame | rest] = Enum.reverse(game)
    [previous_frame | _] = rest
    score( Frame.total(last_frame, (needs_doubling?(previous_frame))), rest )
  end

  def score(game) do
    last_frame = last_set(game)
    score( Frame.total(last_frame), [] )
  end

  def score(acc, []) do
    acc
  end

  def score(acc, game) when length(game)>2 do
    [last_frame | rest] = game
    [previous_frame | [frame_before_that | _]] = rest
    score(acc + Frame.total(last_frame, (needs_doubling?(previous_frame, frame_before_that))), rest )
  end

  def score(acc, game) when length(game)>1 do
    [last_frame | rest] = game
    [previous_frame | _ ] = rest
    score(acc + Frame.total(last_frame, (needs_doubling?(previous_frame))), rest )
  end


  def score(acc, game) do
    last_frame = last_set(game)
    score(acc + Frame.total(last_frame), [] )
  end

  defp add_frame(false, game, pins) do
    List.replace_at(game, -1, Frame.add_roll(last_set(game), pins))
  end

  defp add_frame(true, game, pins) when length(game)<10 do
    game ++ [Frame.new(pins)]
  end

  defp add_frame(true, _, _) do
    raise "This game is finished!"
  end

  defp last_set(game) do
    List.last(game)
  end

  defp needs_doubling?(%Frame{first: 10}, %Frame{first: 10}) do
    :double_strike
  end

  defp needs_doubling?(frame, _) do
    needs_doubling?(frame)
  end

  defp needs_doubling?(%Frame{first: 10}) do
    :strike
  end

  defp needs_doubling?(frame) do
    cond do
      Frame.total(frame) == 10 ->
        :spare
      true ->
        :regular
    end
  end
end
