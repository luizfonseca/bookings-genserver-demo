defmodule User do
  defstruct name: "Luiz Fonseca",
            timestamp: DateTime.utc_now

  def new do
    %__MODULE__{ name: random_name() }
  end

  def random_name do
    Enum.random(["Luiz", "Thiago", "Femi", "Vitor", "Nicolas", "Yone", "Adam"])
  end
end
