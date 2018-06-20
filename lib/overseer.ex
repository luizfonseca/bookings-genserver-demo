defmodule Overseer do
  use Supervisor

  @impl true
  def init(_) do
    children = [ Queue, Solver ]
    options = [ strategy: :one_for_one, name: D2D.Overseer ]

    Supervisor.start_link(children, options)
  end
end
