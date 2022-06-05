defmodule Temp.Tracker.Hub do
  use GenServer

  @spec start_link(any()) :: Agent.on_start()
  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: :tracker_hub)
  end

  @impl true
  def init(_) do
    {:ok, nil}
  end

  # passes the pid of caller process to monitor it
  @spec start_child() :: GenServer.on_start()
  def start_child() do
    GenServer.call(:tracker_hub, {:start_child, self()})
  end

  @impl true
  def handle_call({:start_child, caller_pid}, _, nil) do
    {:reply, Temp.Tracker.start_link(caller_pid), nil}
  end
end
