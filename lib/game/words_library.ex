defmodule Game.WordsLibrary do
  @moduledoc "Logic to fetch words for guessing"

  @words ~w(
    aback abase abate abbey abbot abhor abide abled abode abort about above abuse abyss acorn acrid actor acute adage
    bacon badge badly bagel baggy baker baler balmy banal banjo barge baron basal basic basil basin basis baste batch
    cabal cabby cabin cable cacao cache cacti caddy cadet cagey cairn camel cameo canal candy canny canoe canon caper
    daddy daily dairy daisy dally dance dandy datum daunt dealt death debar debit debug debut decal decay decor decoy
  )

  @doc "Returns a random word to guess"
  @spec word() :: String.t()
  def word, do: Enum.random(@words)
end
