defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "Roll a zero" do
    game = Game.new()
    assert Game.roll(game, 0) == [[0]]
  end

  test "Roll two zeros" do
    game = Game.new()
    res = Game.roll(game, 0)
    |> Game.roll(0)
    assert res == [[0, 0]]
  end

  test "Roll a zero and a 2" do
    game = Game.new()
    res = Game.roll(game, 0)
          |> Game.roll(2)
    assert res == [[0, 2]]
  end

  test "Roll a 1 and a 2" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
    assert res == [[1, 2]]
  end

  test "Roll 2 frames" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
          |> Game.roll(5)
          |> Game.roll(2)
    assert res == [[1, 2], [5, 2]]
  end

  test "Roll 3 frames" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
          |> Game.roll(5)
          |> Game.roll(2)
          |> Game.roll(4)
          |> Game.roll(4)
    assert res == [[1, 2], [5, 2], [4, 4]]
  end

  test "Roll a strike" do
    game = Game.new()
    res = Game.roll(game, 1)
          |> Game.roll(2)
          |> Game.roll(10)
          |> Game.roll(4)
          |> Game.roll(4)
    assert res == [[1, 2], [10, nil], [4, 4]]
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
end
