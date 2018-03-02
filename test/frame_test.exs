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
end
