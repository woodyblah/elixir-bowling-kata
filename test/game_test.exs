defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "Roll a zero" do
    game = Game.new()
    assert Game.roll(game, 0) == [%Frame{first: 0}]
  end

  test "Roll two zeros" do
    game = Game.new()
    res = Game.roll(game, 0)
          |> Game.roll(0)
    assert res == [%Frame{first: 0, second: 0}]
  end

  test "Roll a zero and a 2" do
    game = Game.new()
    res = Game.roll(game, 0)
          |> Game.roll(2)
    assert res == [%Frame{first: 0, second: 2}]
  end

  test "Roll a 1 and a 2" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
    assert res == [%Frame{first: 1, second: 2}]
  end

  test "Roll 2 frames" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
          |> Game.roll(5)
          |> Game.roll(2)
    assert res == [%Frame{first: 1, second: 2}, %Frame{first: 5, second: 2}]
  end

  test "Roll 3 frames" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
          |> Game.roll(5)
          |> Game.roll(2)
          |> Game.roll(4)
          |> Game.roll(4)
    assert res == [%Frame{first: 1, second: 2}, %Frame{first: 5, second: 2}, %Frame{first: 4, second: 4}]
  end

  test "Roll a strike" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
          |> Game.roll(10)
          |> Game.roll(4)
          |> Game.roll(4)
    assert res == [%Frame{first: 1, second: 2}, %Frame{first: 10, second: nil}, %Frame{first: 4, second: 4}]
  end

  test "Roll a frame, and get the score" do
    game = Game.new()
    res = Game.roll(game, 1)
            |> Game.roll(2)
      assert Game.score(res) == 3
    end

  test "Roll two frames, and get the score" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
          |> Game.roll(4)
          |> Game.roll(4)
    assert Game.score(res) == 11
  end

  test "Roll a strike, and get the score" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
          |> Game.roll(10)
          |> Game.roll(4)
          |> Game.roll(4)
    assert Game.score(res) == 29
  end

  test "Roll a spare, and get the score" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
          |> Game.roll(8)
          |> Game.roll(2)
          |> Game.roll(4)
          |> Game.roll(4)
    assert Game.score(res) == 25
  end

  test "Roll a spare, and a strike, and get the score" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
          |> Game.roll(8)
          |> Game.roll(2)
          |> Game.roll(10)
          |> Game.roll(4)
          |> Game.roll(4)
    assert Game.score(res) == 49
  end

#  test "Roll two strikes, and get the score" do
#    game = Game.new()
#    res = Game.roll(game, 1)
#          |> Game.roll(2)
#          |> Game.roll(10)
#    IO.puts(Game.score(res))
#    res = Game.roll(res, 10)
#    IO.puts(Game.score(res))
#    res = Game.roll(res, 4)
#          |> Game.roll(4)
#    assert Game.score(res) == 53
#  end
end
