defmodule Solver do
  use GenServer

  @initial_state %{ max_duration: 900 }

  @doc """
  Client
  """
  def start_link(_) do
    GenServer.start_link(__MODULE__, Queue.list, name: __MODULE__)
  end

  @doc """
  Server
  """
  @impl true
  def init(args) do
    schedule_pooler()
    { :ok, args }
  end

  @doc """
  Callback
  """
  @impl true
  def handle_info(:solve, _state) do

    Queue.list
    |> Enum.map(fn booking -> sort(booking) end)

    schedule_pooler()
    { :noreply, Queue.list }
  end

  @doc """
  Update bookings ++ trip duration
  """
  def sort(booking) do
    unless booking.trip do
      trip = %Trip{
        duration: :rand.uniform(@initial_state.max_duration),
        pickup_time: Time.utc_now
      }

      booking = %{ booking | trip: trip }
      in_minutes = Float.round(trip.duration / 60, 0)

      IO.puts("
              #{booking.user.name} booking is at 
              #{trip.pickup_time}. It will take #{in_minutes} minutes")

      Process.sleep(8000)

      Queue.update(booking)
      Queue.clear()
      booking
    end

  end

  @doc """
  Keep running
  """
  def schedule_pooler do
    Queue.clear()
    send self(), :solve
  end
end
