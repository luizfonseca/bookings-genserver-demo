defmodule Trip do
  @enforce_keys [:duration, :pickup_time]
  defstruct duration: 0,
            pickup_time: nil,
            date: DateTime.utc_now
end
