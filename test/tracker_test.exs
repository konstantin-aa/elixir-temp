defmodule Temp.TrackerTest do
  use ExUnit.Case, async: true

  test "automatically cleans up" do
    dir = Temp.mkdir!()
    assert File.exists?(dir)

    normal_end =
      Task.async(fn ->
        Temp.track!()
        Temp.track_file(dir)
        :ok
      end)

    Task.await(normal_end)
    :timer.sleep(50)
    refute File.exists?(dir)
  end

  test "automatically cleans up after crashes" do
    dir = Temp.mkdir!()
    assert File.exists?(dir)

    Task.start(fn ->
      Temp.track!()
      Temp.track_file(dir)
      Process.exit(self(), :kill)
      :ok
    end)

    :timer.sleep(50)
    refute File.exists?(dir)
  end
end
