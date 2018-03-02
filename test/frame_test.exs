defmodule FrameTest do
  use ExUnit.Case
  doctest Frame

  test "Create a frame" do
    f = Frame.new()
    assert f == %Frame{first: nil, second: nil}
  end

  test "Create a frame with a first roll" do
    f = Frame.new(5)
    assert f == %Frame{first: 5, second: nil}
  end

  test "add a second roll" do
    f = Frame.new(5)
    assert Frame.add_roll(f, 3) == %Frame{first: 5, second: 3}
  end

  test "add a third roll" do
    f = Frame.new(5)
        |> Frame.add_roll(5)
    assert Frame.add_roll(f, 3) == %Frame{first: 5, second: 5, third: 3}
  end

  test "Get the frame total" do
    f = %Frame{first: 5, second: 3}
    assert Frame.total(f) == 8
  end

  test "Get the frame total with only one roll" do
    f = Frame.new(5)
    assert Frame.total(f) == 5
  end

  test "Get the frame total with a strike" do
    f = Frame.new(10)
    assert Frame.total(f) == 10
  end

  test "Get a frame total where the previous frame was a spare" do
    f = %Frame{first: 5, second: 3}
    assert Frame.total(f, :spare) == 13
  end

  test "Get a frame total where the previous frame was a strike" do
    f = %Frame{first: 5, second: 3}
    assert Frame.total(f, :strike) == 16
  end

  test "Get a frame total where both the previous frame were a strike" do
    f = %Frame{first: 5, second: 3}
    assert Frame.total(f, :double_strike) == 21
  end

  test "Get a strike frame total where the previous frame was a spare" do
    f = Frame.new(10)
    assert Frame.total(f, :spare) == 20
  end

  test "Get a strike frame total where the previous frame was a strike" do
    f = Frame.new(10)
    assert Frame.total(f, :strike) == 20
  end

  test "Get a strike frame total where both the previous frames were a strike" do
    f = Frame.new(10)
    assert Frame.total(f, :double_strike) == 30
  end

  test "Get the total of a final frame" do
    f = %Frame{first: 5, second: 3}
    assert Frame.total(f, :regular, :final_frame) == 8
  end

  test "Get the total of a final frame with a spare" do
    f = %Frame{first: 5, second: 5, third: 2}
    assert Frame.total(f, :regular, :final_frame) == 12
  end

  test "Get the total of a final frame with a strike" do
    f = %Frame{first: 10, second: 3, third: 2}
    assert Frame.total(f, :regular, :final_frame) == 15
  end

  test "Get the total of a final frame with two strikes" do
    f = %Frame{first: 10, second: 10, third: 2}
    assert Frame.total(f, :regular, :final_frame) == 22
  end

  test "Get the total of a final frame with two strikes and a preceeding strike" do
    f = %Frame{first: 10, second: 10, third: 2}
    assert Frame.total(f, :strike, :final_frame) == 42
  end

  test "Get the total of a final frame with two strikes and two preceeding strikes" do
    f = %Frame{first: 10, second: 10, third: 2}
    assert Frame.total(f, :double_strike, :final_frame) == 52
  end

  test "A Frame in an incomplete game with only one roll is not complete" do
    f = Frame.new(5)
    refute Frame.complete?(1, f)
  end

  test "A Frame in an incomplete game with only one roll of 10 is complete" do
    f = Frame.new(10)
    assert Frame.complete?(1, f)
  end

  test "A Frame in an incomplete game with two rolls is complete" do
    f = %Frame{first: 5, second: 3}
    assert Frame.complete?(1, f)
  end

  test "A Frame in a complete game with only one roll is not complete" do
    f = Frame.new(5)
    refute Frame.complete?(10, f)
  end

  test "A Frame in a complete game with two rolls is complete" do
    f = %Frame{first: 5, second: 3}
    assert Frame.complete?(10, f)
  end

  test "A Frame in a complete game with a spare is not complete" do
    f = %Frame{first: 5, second: 5}
    refute Frame.complete?(10, f)
  end

  test "A Frame in a complete game with a strike is not complete" do
    f = Frame.new(10)
    refute Frame.complete?(10, f)
  end

  test "A Frame in a complete game with a strike and a second roll is not complete" do
    f = %Frame{first: 10, second: 5}
    refute Frame.complete?(10, f)
  end

  test "A Frame in a complete game with two strikes is not complete" do
    f = %Frame{first: 10, second: 10}
    refute Frame.complete?(10, f)
  end

  test "A Frame in a complete game with three rolls is complete" do
    f = %Frame{first: 10, second: 4, third: 4}
    assert Frame.complete?(10, f)
  end
end
