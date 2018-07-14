defmodule Booking do
  defstruct to:   "Alexanderplatz. #{:rand.uniform(100)}",
            from: "Torstr. #{:rand.uniform(100)}",
            timestamp: DateTime.utc_now,
            user: nil,
            trip: nil,
            id: nil

  def new do
    %__MODULE__{ id: :rand.uniform(1_000_000), user: User.new }
  end

end
