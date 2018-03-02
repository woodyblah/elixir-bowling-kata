defmodule Frame do
  @moduledoc false
  defstruct [:first, :second]

  def new() do
    %Frame{}
  end

  def new(pins) do
    %Frame{first: pins}
  end

  def add_roll(frame, pins) do
    %{frame | second: pins}
  end

  def total(frame = %Frame{second: nil}) do
    frame.first
  end

  def total(frame) do
    frame.first + frame.second
  end

  def complete?(%Frame{first: 10, second: nil}) do
    true
  end

  def complete?(%Frame{second: nil}) do
    false
  end

  def complete?(_) do
    true
  end
end
