defmodule Game.WordsLibrary do
  @moduledoc "Logic to fetch words for guessing"

  @words ~w(
    other
    words
  )

  @doc "Returns a random word to guess"
  @spec word() :: String.t()
  def word, do: Enum.random(@words)
end
