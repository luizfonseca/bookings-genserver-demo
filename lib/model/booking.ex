defmodule Booking do
  defstruct user: %User{},
            from: "Torstr. #{:rand.uniform(100)}",
            to:   "Cotheniusstr. #{:rand.uniform(100)}",
            trip: nil,
            timestamp: DateTime.utc_now,
            id: nil

  def new do
    %__MODULE__{ id: :rand.uniform(1_000_000), user: %User{ name: User.new } }
  end

end
