defmodule Queue do
  use GenServer
  require Logger

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @doc """
  Server callbacks
  """
  @impl true
  def init(state), do: { :ok, state }

  @doc """
  Callback async
  """
  @impl true
  def handle_cast({ :add, client }, state) do
    { :noreply, [ client | state ] }
  end

  @impl true
  def handle_cast({ :update, booking }, state) do
    new_state = Enum.reject(state, fn(s) -> s.id == booking.id end)
    { :noreply, [ booking | new_state ] }
  end

  @doc """
  Callback sync
  """
  @impl true
  def handle_call(:clear, _, state) do
    { :reply, state, remove_solved(state) }
  end

  @doc """
  Callback sync
  """
  @impl true
  def handle_call(:list, _from, state) do
    { :reply, state, state }
  end


  def add(item), do: GenServer.cast(__MODULE__, { :add, item })
  def update(item), do: GenServer.cast(__MODULE__, { :update, item })
  def list, do: GenServer.call(__MODULE__, :list)
  def clear, do: GenServer.call(__MODULE__, :clear)
  def remove_solved(state), do: Enum.reject(state, fn(bk) -> bk.trip != nil end)

end
