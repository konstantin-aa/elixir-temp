defmodule Temp.Application do
  use Application

  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    children = [
      Temp.Tracker.Hub
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
