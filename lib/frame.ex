defmodule Frame do
  @moduledoc false
  defstruct [:first, :second, :third]

  def new() do
    %Frame{}
  end

  def new(pins) do
    %Frame{first: pins}
  end

  def add_roll(frame = %Frame{second: nil}, pins) do
    %{frame | second: pins}
  end

  def add_roll(frame, pins) do
    %{frame | third: pins}
  end

  def total(frame = %Frame{second: nil}) do
    frame.first
  end

  def total(frame) do
    frame.first + frame.second
  end

  def total(frame, :double_strike) do
    frame.first+(total(frame)*2)
  end

  def total(frame, :strike) do
    total(frame)*2
  end

  def total(frame, :spare) do
    total(frame)+frame.first
  end

  def total(frame, :regular) do
    total(frame)
  end

  def total(frame, double?, :final_frame) do
    total(frame, double?) + third_roll(frame)
  end

  def complete?(10, frame) do
    cond do
      frame.third != nil  -> true
      total(frame) >= 10  -> false
      frame.second == nil -> false
      true -> true
    end
  end

  def complete?(_, frame) do
    complete?(frame)
  end

  defp complete?(%Frame{first: 10, second: nil}) do
    true
  end

  defp complete?(%Frame{second: nil}) do
    false
  end

  defp complete?(_) do
    true
  end

  defp third_roll(frame) do
    cond do
      total(frame) >= 10 -> frame.third
      true -> 0
    end
  end
end
