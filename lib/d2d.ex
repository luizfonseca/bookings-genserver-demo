defmodule D2D do
  use Application

  def start(_type, _args) do
    Overseer.init([])
  end
end
