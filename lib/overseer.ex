defmodule Overseer do
  use Supervisor

  @impl true
  def init(_) do
    children = [ Queue, Solver ]
    options = [ strategy: :one_for_one, name: __MODULE__ ]

    Supervisor.start_link(children, options)
  end
end
